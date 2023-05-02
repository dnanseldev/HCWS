SELECT ROWNUM,
       X.QTD_FUNCIONARIO_TRIAGEM,
       X.NUM_TRIAGEM_OS,
       X.NUM_ORDEM,
       X.COD_PACIENTE,
       'N' IDF_SELECIONADO,
       'N' IDF_DESAPARECER,
       X.DTA_TRIAGEM,
       X.DSC_TECNICA_SERVICO,
       X.DTA_CRIACAO,
       X.OS,
       X.NUM_ORDEM_SERVICO,
       X.ANO_ORDEM_SERVICO,
       X.COD_CENCUSTO,
       X.COD_SITUACAO_OS,
       X.COD_LOCAL,
       X.IDF_PRIORIZADO,
       X.NUM_RAMAL,
       X.NOM_CONTATO,
       X.NUM_BEM,
       X.COD_UNIDADE_EXECUTANTE,
       X.NOM_PATRIMONIO,
       X.NOM_LOCAL,
       X.CENTRO_CUSTO,
       X.USU_TRIADOR,
       X.COD_UNIADM,
       X.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO,
       X.DSC_TIPO_EQUIPAMENTO,
       X.NUM_MAN_PREVENTIVA

  FROM (
        
        SELECT DISTINCT A.NUM_TRIAGEM_OS,
                         
               (SELECT COUNT(*)                          
                  FROM FUNCIONARIO_ORDEM_SERVICO FOS1                          
                 WHERE FOS1.NUM_TRIAGEM_OS = A.NUM_TRIAGEM_OS                                
                   AND FOS1.DTA_HOR_FINALIZACAO =
                       TO_DATE('01/01/1800', 'DD/MM/YYYY')) QTD_FUNCIONARIO_TRIAGEM,
                         
               B.DTA_CRIACAO_OS  DTA_CRIACAO,
               B.COD_PACIENTE,
               B.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO,
                         
               CASE
                 WHEN B.NUM_MAN_PREVENTIVA IS NOT NULL THEN                           
                  '<<MANUTEN��O PREVENTIVA>>'
                         
                 ELSE                           
                  (SELECT DISTINCT OSTE.NOM_ORDEM_SERV_TIPO_EMPRESTIMO                             
                     FROM GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE                             
                     JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE
                       ON TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO = BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO                             
                     JOIN GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OSTE
                       ON OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO =TIE.SEQ_CODIGO_SISTEMA_ORIGEM                             
                    WHERE OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO = B.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO)
                         
               END AS DSC_TIPO_EQUIPAMENTO,                         
               A.DTA_HOR_TRIAGEM DTA_TRIAGEM,                         
               B.NUM_ORDEM,
               TO_CHAR(B.NUM_ORDEM_SERVICO, 999999) || '/' || B.ANO_ORDEM_SERVICO OS,                         
               B.NUM_ORDEM_SERVICO,
               B.ANO_ORDEM_SERVICO,
               SUBSTR(B.DSC_TECNICA_SERVICO, 1, 250) DSC_TECNICA_SERVICO,                         
               B.COD_CENCUSTO,
               B.COD_SITUACAO_OS,
               B.COD_LOCAL,
               B.IDF_PRIORIZADO,
               B.NUM_MAN_PREVENTIVA,                         
               B.NUM_RAMAL,
               B.NOM_CONTATO,
               B.NUM_BEM,
               B.COD_UNIDADE_EXECUTANTE,
                         
               NVL(TRIM(SUBSTR(FC_NOM_BEM_PATRIMONIAL(B.NUM_BEM), 1,100)), '        ***** SERVI�O *****') NOM_PATRIMONIO,                         
               CASE B.COD_UNIDADE_EXECUTANTE                         
                 WHEN 188 THEN B.CPL_LOCAL                         
                 WHEN 189 THEN B.CPL_LOCAL                         
                 ELSE
                  C.NOM_LOCAL                         
               END NOM_LOCAL,                         
               C.COD_UNIADM,                         
               D.COD_CENCUSTO || '-' || D.NOM_CENCUSTO CENTRO_CUSTO,                         
               F.NOM_USUARIO || ' ' || F.SBN_USUARIO USU_TRIADOR        
          FROM TRIAGEM_ORDEM_SERVICO A,
                ORDEM_SERVICO         B,
                LOCAL                 C,
                CENTRO_CUSTO          D,                
                USUARIO   F,
                INSTITUTO INST,
                
                (SELECT COD_UNIDADE_EXECUTANTE                 
                   FROM UNIDADE_EXECUTANTE                 
                  START WITH COD_UNIDADE_EXECUTANTE IN (188)                 
                 CONNECT BY PRIOR
                             COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI) UE
        
         WHERE A.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE              
           AND A.DTA_HOR_FIM_TRIAGEM = TO_DATE('01/01/1800', 'DD/MM/YYYY')              
           AND B.COD_SITUACAO_OS IN (2, 3)              
           AND A.NUM_ORDEM = B.NUM_ORDEM              
           AND A.NUM_TRIAGEM_OS NOT IN
               (SELECT NUM_TRIAGEM_OS
                  FROM FUNCIONARIO_ORDEM_SERVICO FOS                
                 WHERE FOS.NUM_TRIAGEM_OS = A.NUM_TRIAGEM_OS                      
                   AND FOS.DTA_HOR_FINALIZACAO = TO_DATE('01/01/1800', 'DD/MM/YYYY'))
              
           AND A.NUM_USER_BANCO = F.NUM_USER_BANCO              
           AND B.COD_LOCAL = C.COD_LOCAL(+)              
           AND B.COD_CENCUSTO = D.COD_CENCUSTO              
           AND D.COD_INSTITUTO = INST.COD_INSTITUTO              
           AND INST.COD_INST_SISTEMA = 1
        -- AND b.num_ordem IN (1353407, 1353408)
        
         ORDER BY DTA_TRIAGEM DESC        
        ) X
 ORDER BY ROWNUM;
