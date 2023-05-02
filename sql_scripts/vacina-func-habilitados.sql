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
