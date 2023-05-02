/*Emprestimo disponiveis*/
SELECT W.DTA_HOR_EMPRESTIMO,
       W.NUM_PATRIMONIO,
       W.COD_TIPO_PATRIMONIO,
       W.DSC_TIPO_PATRIMONIO,
       W.NUM_BEM,
       
       W.NOM_BEM,
       W.LOCALIZACAO,
       W.EMPRESTADO,
       W.NUM_EMPRESTIMO,
       W.NUM_USER_EMPRESTIMO,
       W.DSC_TIPO_EMPRESTIMO,
       
       W.COD_UNIDADE_EXECUTANTE,
       W.DTA_HOR_DEVOLUCAO,
       W.DTA_DEVOLUCAO_PREVISTA,
       W.NOM_SOLICITANTE,
       
       W.COD_LOCALIZACAO,
       W.COD_LOCALIZACAO_ANTERIOR,
       W.DSC_OBSERVACAO,
       W.NUM_ORDEM,
       W.NUM_USER_DEVOLUCAO,
       
       W.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO,
       W.COD_PACIENTE,
       W.COD_CENCUSTO,
       W.STATUS,
       W.NUM_OS,
       W.USUARIO,
       
       W.CCUSTO,
       W.DSC_SITUACAO_OS,
       W.NOM_UNIDADE_EXECUTANTE,
       W.IDF_EMPRESTIMO,
       W.STATUS_NOVO

  FROM (
        
        SELECT Z.DTA_HOR_EMPRESTIMO,
                Z.NUM_PATRIMONIO,
                Z.COD_TIPO_PATRIMONIO,
                Z.DSC_TIPO_PATRIMONIO,
                Z.NUM_BEM,
                Z.NOM_BEM,
                Z.LOCALIZACAO,
                
                DECODE(Z.IDF_EMPRESTIMO,
                       0,
                       'NÃO VINCULADO',
                       1,
                       'PACIENTE',
                       2,
                       'SEÇÃO') DSC_TIPO_EMPRESTIMO,
                Z.IDF_EMPRESTIMO,
                
                EE.DTA_DEVOLUCAO_PREVISTA EMPRESTADO,
                EE.NUM_EMPRESTIMO,
                EE.NUM_USER_EMPRESTIMO,
                
                EE.COD_UNIDADE_EXECUTANTE,
                EE.DTA_HOR_DEVOLUCAO,
                EE.DTA_DEVOLUCAO_PREVISTA,
                EE.NOM_SOLICITANTE,
                
                EE.COD_LOCALIZACAO,
                EE.COD_LOCALIZACAO_ANTERIOR,
                EE.DSC_OBSERVACAO,
                EE.NUM_ORDEM,
                EE.NUM_USER_DEVOLUCAO,
                
                EE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO,
                EE.COD_PACIENTE,
                EE.COD_CENCUSTO,
                
                Z.STATUS_NOVO,
                
                CASE
                  WHEN EE.DTA_HOR_DEVOLUCAO =
                       TO_DATE('01/01/1800', 'DD/MM/YYYY') THEN
                   'EMPRESTADO'
                
                  ELSE
                   'DISPONIVEL'
                
                END AS STATUS,
                
                (SELECT XC.NUM_ORDEM_SERVICO || '/' || XC.ANO_ORDEM_SERVICO
                 
                   FROM ORDEM_SERVICO XC
                 
                  WHERE XC.NUM_ORDEM = EE.NUM_ORDEM) NUM_OS,
                
                (SELECT XU.NOM_USUARIO || ' - ' || XU.SBN_USUARIO
                 
                   FROM ORDEM_SERVICO XC, USUARIO XU
                 
                  WHERE XC.NUM_ORDEM = EE.NUM_ORDEM
                       
                    AND XC.NUM_USER_BANCO = XU.NUM_USER_BANCO) USUARIO,
                
                (SELECT XE.COD_CENCUSTO || ' - ' || XE.NOM_CENCUSTO
                 
                   FROM ORDEM_SERVICO XC, CENTRO_CUSTO XE
                 
                  WHERE XC.NUM_ORDEM = EE.NUM_ORDEM
                       
                    AND XC.COD_CENCUSTO = XE.COD_CENCUSTO) CCUSTO,
                
                (SELECT XG.DSC_SITUACAO_OS
                 
                   FROM ORDEM_SERVICO XC, TIPO_SITUACAO_OS XG
                 
                  WHERE XC.NUM_ORDEM = EE.NUM_ORDEM
                       
                    AND XC.COD_SITUACAO_OS = XG.COD_SITUACAO_OS) DSC_SITUACAO_OS,
                
                (SELECT XF.NOM_UNIDADE_EXECUTANTE
                 
                   FROM UNIDADE_EXECUTANTE XF
                 
                  WHERE XF.COD_UNIDADE_EXECUTANTE = EE.COD_UNIDADE_EXECUTANTE) NOM_UNIDADE_EXECUTANTE
        
          FROM (
                 
                 SELECT MAX(EE.DTA_CADASTRO) DTA_HOR_EMPRESTIMO,
                         BP.NUM_PATRIMONIO,
                         BP.COD_TIPO_PATRIMONIO,
                         TP.DSC_TIPO_PATRIMONIO,
                         BP.NUM_BEM,
                         
                         BP.IDF_EMPRESTIMO,
                         SUBSTR(BP.DSC_COMPLEMENTAR, 1, 100) NOM_BEM,
                         
                         SUBSTR(GENERICO.FCN_RETORNA_STATUS_EMPRESTIMO(BP.NUM_BEM),
                                1,
                                20) STATUS_NOVO,
                         
                         DECODE(LC.IDF_UNIDADE_LOCALIZACAO,
                                1,
                                'CAMPUS',
                                2,
                                'U.EMERGENCIA',
                                1,
                                'CAMPUS',
                                4,
                                'U.EMERGENCIA') LOCALIZACAO
                 
                   FROM BEM_PATRIMONIAL              BP,
                         CENTRO_CUSTO_BEM_PATRIMONIAL CP,
                         TIPO_PATRIMONIO              TP,
                         
                         LOCALIZACAO            LC,
                         EMPRESTIMO_EQUIPAMENTO EE,
                         
                         (SELECT BPTE.NUM_BEM, OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO
                          
                            FROM GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE
                          
                            JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE
                              ON TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO =
                                 BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                          
                            JOIN GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OSTE
                              ON OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO =
                                 TIE.SEQ_CODIGO_SISTEMA_ORIGEM) EQUIPAMENTO
                 
                  WHERE CP.COD_CENCUSTO = 'CACK00104'
                       
                    AND CP.NUM_BEM = BP.NUM_BEM
                       
                    AND BP.NUM_BEM = EE.NUM_BEM(+)
                       
                    AND BP.NUM_BEM = EQUIPAMENTO.NUM_BEM(+)
                       
                    AND CP.DTA_FIM IS NULL
                       
                    AND EQUIPAMENTO.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO = 18
                    --AND bp.dsc_complementar IS NULL
                       
                    AND CP.COD_LOCALIZACAO = LC.COD_LOCALIZACAO
                       
                    AND BP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
                 
                  GROUP BY BP.NUM_PATRIMONIO,
                            BP.COD_TIPO_PATRIMONIO,
                            TP.DSC_TIPO_PATRIMONIO,
                            BP.NUM_BEM,
                            
                            BP.IDF_EMPRESTIMO,
                            SUBSTR(BP.DSC_COMPLEMENTAR, 1, 100),
                            
                            DECODE(LC.IDF_UNIDADE_LOCALIZACAO,
                                   1,
                                   'CAMPUS',
                                   2,
                                   'U.EMERGENCIA',
                                   1,
                                   'CAMPUS',
                                   4,
                                   'U.EMERGENCIA')
                 
                 ) Z,
                EMPRESTIMO_EQUIPAMENTO EE
        
         WHERE Z.NUM_BEM = EE.NUM_BEM(+)
              
           AND Z.DTA_HOR_EMPRESTIMO = EE.DTA_CADASTRO(+)
        
        ) W

 ORDER BY W.NUM_PATRIMONIO;
--------------------------------
SELECT BPTE.NUM_BEM, OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO

  FROM GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE

  JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE
    ON TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO = BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO

  JOIN GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OSTE
    ON OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO = TIE.SEQ_CODIGO_SISTEMA_ORIGEM
 WHERE OSTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO = 18;
 
 
 SELECT *
  FROM bem_patrimonial bp
  WHERE bp.num_patrimonio = 28318
  AND bp.cod_tipo_patrimonio = 56;
-- AND bp.num_bem in (223600, 223602, 223611, 223629, 223646, 224379, 224380, 224381, 224382, 224383, 224384, 224387, 224388, 224389);
  
  UPDATE  bem_patrimonial bp
  SET bp.dsc_complementar = 'BOMBA DE INFUSAO DE SERINGA'
  WHERE bp.num_bem in (223600, 223602, 223611, 223629, 223646, 224379, 224380, 224381, 224382, 224383, 224384, 224387, 224388, 224389);
  
  --BOMBA DE INFUSAO
  SELECT bp.num_bem,
         BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
         bp.dsc_complementar 
   FROM centro_custo_bem_patrimonial ccbp   
   JOIN bem_patrimonial bp ON bp.num_bem = ccbp.num_bem
   JOIN BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE ON BPTE.Num_Bem = bp.num_bem
   WHERE 1 = 1
   AND ccbp.cod_cencusto = 'CACK00104'
   AND bp.dsc_complementar LIKE '%DE SERINGA%'
   AND ccbp.dta_fim IS NULL
   AND BPTE.Seq_Tipo_Imagem_Equipamento = 1;
   
   SELECT *
    FROM  GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE
    WHERE tie.seq_tipo_imagem_equipamento = 5;
    
   /* UPDATE BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE
    SET BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO = 5
    WHERE BPTE.NUM_BEM
   in (107386, 104824, 107378, 107388, 115360, 115363, 104846, 98920, 98919, 104817, 104836, 104833, 104811, 220594, 220593, 220592, 220591, 220590, 220589, 220587, 220586, 220585, 220583, 220690, 220689, 220688, 220687, 220686, 220685, 220683, 220682, 220681, 115372, 104821);*/
   
  SELECT * FROM EMPRESTIMO_EQUIPAMENTO EE 
    WHERE EE.NUM_BEM
    in (107386, 104824, 107378, 107388, 115360, 115363, 104846, 98920, 98919, 104817, 104836, 104833, 104811, 220594, 220593, 220592, 220591, 220590, 220589, 220587, 220586, 220585, 220583, 220690, 220689, 220688, 220687, 220686, 220685, 220683, 220682, 220681, 115372, 104821);
