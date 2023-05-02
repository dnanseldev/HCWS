CREATE OR REPLACE VIEW GENERICO.V_DADOS_VACIVIDA_EXTERNO AS
SELECT DISTINCT Y."COD_PACIENTE" ,Y."CPF_PACIENTE"
  FROM (
        -- Pacientes Internados
        SELECT P.COD_PACIENTE
               ,P.CPF_PACIENTE
          FROM PACIENTE_EM_ATENDIMENTO PA
               ,PACIENTE                P
         WHERE PA.COD_TIPO_ATENDIMENTO IN (2, 4)
           AND PA.COD_PACIENTE = P.COD_PACIENTE
           AND (EXISTS (SELECT 1
                  FROM DIAGNOSTICO_ATENDIMENTO_PAC DAP
                  WHERE DAP.SEQ_ATENDIMENTO = PA.SEQ_ATENDIMENTO
                    AND DAP.COD_CID_10 IN ('U07', 'U071', 'B342'))
                OR substr(GENERICO.FCN_EMITE_ALERTA_COVID(PA.COD_PACIENTE),1,2)<> 'OK')
--           AND EXISTS (SELECT 1
--                  FROM DIAGNOSTICO_ATENDIMENTO_PAC DAP
--                 WHERE DAP.SEQ_ATENDIMENTO = PA.SEQ_ATENDIMENTO
--                   AND DAP.COD_CID_10 IN ('U07', 'U071', 'B342'))
           AND P.CPF_PACIENTE IS NOT NULL
           AND NOT EXISTS (SELECT L.CPF_PACIENTE, L.DTA_HOR_EXECUCAO
                  FROM LOG_RPA_VACIVIDA_EXTERNO L
                 WHERE L.CPF_PACIENTE = P.CPF_PACIENTE
                   AND TRUNC(L.DTA_HOR_EXECUCAO) >= TRUNC(SYSDATE) - 10)
        UNION ALL
        -- Funcionarios habilitados para facina¿Æo que reportaram vacina¿Æo externa
        SELECT X.COD_PACIENTE, X.NUM_CPF
          FROM (SELECT DISTINCT LPAD(A.NUM_CPF, 11, '0') NUM_CPF
                                ,P.COD_PACIENTE
                                ,UPPER(A.NOM_FUNCIONARIO) NOME_SIS_VACINA
                                ,UPPER(P.NOM_PACIENTE || ' ' || P.SBN_PACIENTE) NOME_PRONTUARIO
                                ,A.COD_INSTITUTO
                                ,UTL_MATCH.EDIT_DISTANCE(UPPER(A.NOM_FUNCIONARIO), UPPER(P.NOM_PACIENTE || ' ' || P.SBN_PACIENTE)) DIF_NOME
                                ,A.IDF_FORM_RESP_EXP
                                ,DECODE(A.IDF_FORM_RESP_EXP, 1, 'VACINADO OUTRA INSTITUI¿ÇO', 2, 'VACINADO POR PESQUISA') STATUS
                   FROM AG_HABILITACAO_VACINA A
                       ,PACIENTE              P
                  WHERE A.IDF_FORM_RESP_EXP IN (1, 2)
                    AND A.COD_CAMPANHA = 1
                    AND LPAD(A.NUM_CPF, 11, '0') = P.CPF_PACIENTE) X
         WHERE X.DIF_NOME < 16 -- indice de confia¿a de igualdade do nome do paciente
           AND NOT EXISTS (SELECT L.CPF_PACIENTE
                      ,L.DTA_HOR_EXECUCAO
                  FROM LOG_RPA_VACIVIDA_EXTERNO L
                 WHERE L.CPF_PACIENTE = X.NUM_CPF
                   AND TRUNC(L.DTA_HOR_EXECUCAO) >= TRUNC(SYSDATE) - 10)
        UNION ALL
        -- Funcionarios vacinados com dados incompletos de vacina¿Æo
        SELECT PRONTUARIO
               ,LPAD(NUMCPF, 11, '0') NUMCPF
          FROM (SELECT F.NUMCPF
                       ,P.COD_PACIENTE PRONTUARIO
                       ,RANK() OVER(PARTITION BY F.NUMCPF ORDER BY S.CODSIT, F.NUMEMP DESC, F.DATADM, UTL_MATCH.EDIT_DISTANCE(UPPER(F.NOMFUN), P.NOM_PACIENTE || ' ' || P.SBN_PACIENTE)) ORDEM
                   FROM R034FUN F
                   LEFT JOIN R034CPL C
                     ON C.TIPCOL = F.TIPCOL
                    AND C.NUMCAD = F.NUMCAD
                    AND C.NUMEMP = F.NUMEMP
                   LEFT JOIN R010SIT S
                     ON S.CODSIT = F.SITAFA
                   JOIN PACIENTE P
                     ON P.CPF_PACIENTE = LPAD(F.NUMCPF, 11, '0')
                    AND --Mesmo CPF
                        UTL_MATCH.EDIT_DISTANCE(UPPER(F.NOMFUN), P.NOM_PACIENTE || ' ' || P.SBN_PACIENTE) < 16
                    AND --Grafia de nome semelhante
                        P.IDF_SEXO = F.TIPSEX
                    AND --Mesmo Sexo
                        TRUNC(P.DTA_NASCIMENTO) = TRUNC(F.DATNAS)
                    AND --Mesma data de nascimento
                        P.COD_REGISTRO_ORIGINAL IS NULL --Considerar registro ativo atual (desconsidera o duplicado)
                  WHERE F.TIPCOL = 1
                    AND ((F.NUMEMP = 2 AND F.NUMCAD <= 18000) OR (F.NUMEMP = 1 AND F.USU_PROSEL NOT IN ('I', 'J', 'X')))
                    AND F.CODFIL IN (1, 2, 3)
                    AND NOT EXISTS (SELECT A.DATAFA
                           FROM R038AFA A
                          WHERE A.NUMEMP = F.NUMEMP
                            AND A.TIPCOL = 1
                            AND A.NUMCAD = F.NUMCAD
                            AND A.DATAFA < TO_DATE('19/01/2021', 'DD/MM/YYYY')
                            AND A.SITAFA IN (SELECT CODSIT
                                               FROM R010SIT
                                              WHERE TIPSIT = 7))
                       --Exclui pacientes nÆo vacinados e que nÆo sÆo pesquisa
                    AND F.NUMCPF NOT IN (SELECT X.NUM_CPF
                                           FROM (SELECT A.NUM_CPF
                                                       ,D.DAT_HOR_RETIRADA DTA_VACINOU
                                                       ,A.IDF_FORM_RESP_EXP
                                                   FROM AG_HABILITACAO_VACINA               A
                                                       ,AG_HABILITACAO_VACINA_FUN           B
                                                       ,DISTRIBUICAO_LISTA_FUNC             D
                                                       ,GENERICO.DISTRIBUICAO_LOCAL_ENTREGA L
                                                       ,USUARIO                             U
                                                       ,AG_CAMPANHA                         C
                                                  WHERE A.SEQ_HAB_CERT_DIGITAL = D.DSC_CHAVE(+)
                                                    AND A.SEQ_HAB_CERT_DIGITAL_FUN = B.SEQ_HAB_CERT_DIGITAL_FUN(+)
                                                    AND A.COD_INSTITUTO IN (1, 2)
                                                    AND D.NOM_TABELA_ORIGEM(+) = 'AG_HABILITACAO_VACINA'
                                                    AND D.SEQ_LOCAL_ENTREGA = L.SEQ_LOCAL_ENTREGA(+)
                                                    AND D.NUM_USER_LIBER = U.NUM_USER_BANCO(+)
                                                    AND A.COD_CAMPANHA = C.COD_CAMPANHA
                                                    AND A.COD_CAMPANHA = 1 --COVID-19 2021
                                                    AND A.SEQ_HAB_CERT_DIGITAL_PAI IS NULL) X
                                          WHERE X.DTA_VACINOU IS NOT NULL
                                             OR NVL(X.IDF_FORM_RESP_EXP, -1) = 2)
                       --Exclui pacientes que nÆo tomaram a primeira dose
                    AND P.COD_PACIENTE NOT IN (SELECT PV.COD_PACIENTE
                                                 FROM VACINACAO          VN
                                                     ,PACIENTE_VACINACAO PV
                                                     ,TIPO_VACINA        TV
                                                     ,DOSE               D
                                                     ,VACINA             V
                                                     ,PACIENTE           P
                                                     ,LOTE_VACINA        L
                                                WHERE VN.COD_PACIENTE_VACINACAO = PV.COD_PACIENTE_VACINACAO
                                                  AND VN.COD_TIPO_VACINA = V.COD_TIPO_VACINA
                                                  AND VN.NUM_DOSE = V.NUM_DOSE
                                                  AND V.COD_TIPO_VACINA = TV.COD_TIPO_VACINA
                                                  AND V.NUM_DOSE = D.NUM_DOSE
                                                  AND P.COD_PACIENTE = PV.COD_PACIENTE
                                                  AND L.COD_LOTE_VACINA = VN.COD_LOTE_VACINA
                                                     --COVID-19
                                                  AND TV.COD_TIPO_VACINA = 70
                                                     --Primeira dose
                                                  AND V.NUM_DOSE = 10)
                    AND NOT EXISTS (SELECT L.CPF_PACIENTE
                               ,L.DTA_HOR_EXECUCAO
                           FROM LOG_RPA_VACIVIDA_EXTERNO L
                          WHERE L.CPF_PACIENTE = LPAD(F.NUMCPF, 11, '0')
                            AND TRUNC(L.DTA_HOR_EXECUCAO) >= TRUNC(SYSDATE) - 10)) X
          LEFT JOIN PACIENTE P
            ON P.COD_PACIENTE = PRONTUARIO
         WHERE X.ORDEM = 1
         ORDER BY 1, 2) Y
 WHERE (SELECT COUNT(*)
          FROM VACINACAO          VN
              ,PACIENTE_VACINACAO PV
         WHERE PV.COD_PACIENTE = Y.COD_PACIENTE
           AND VN.COD_PACIENTE_VACINACAO = PV.COD_PACIENTE_VACINACAO
           AND VN.COD_TIPO_VACINA = 70
           AND VN.NUM_DOSE IN (10, 20)) < 2
;
