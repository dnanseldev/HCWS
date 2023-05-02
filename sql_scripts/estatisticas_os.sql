 --Oficinas   
 SELECT Z.*, Y.NOM_INSTITUTO
       FROM (SELECT UE.COD_UNIDADE_EXECUTANTE_PAI,                   
                    (SELECT E.NOM_UNIDADE_EXECUTANTE
                       FROM UNIDADE_EXECUTANTE E
                      WHERE E.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE_PAI) UN_EXECUTANTE,                    
                    RTRIM(XMLAGG(XMLELEMENT(E, UE.NOM_UNIDADE_EXECUTANTE, ',' || CHR(13)).EXTRACT('//text()') ORDER BY UE.NOM_UNIDADE_EXECUTANTE)
                          .GETCLOBVAL(),  ',') OFICINAS,
                          COUNT(*) QTD
               FROM UNIDADE_EXECUTANTE UE 
               WHERE ue.idf_ativo = 0              
              START WITH COD_UNIDADE_EXECUTANTE IN
                         ((SELECT UE.COD_UNIDADE_EXECUTANTE
                            FROM UNIDADE_EXECUTANTE UE
                           WHERE UE.COD_UNIDADE_EXECUTANTE_PAI IS NULL))
             CONNECT BY PRIOR
                         COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI                         
              GROUP BY UE.COD_UNIDADE_EXECUTANTE_PAI) Z              
       JOIN (SELECT UE.COD_UNIDADE_EXECUTANTE, INS.NOM_INSTITUTO
               FROM UNIDADE_EXECUTANTE UE
               JOIN INSTITUTO INS
                 ON INS.COD_INSTITUTO = UE.COD_INSTITUTO
              WHERE UE.COD_UNIDADE_EXECUTANTE_PAI IS NULL) Y
         ON Y.COD_UNIDADE_EXECUTANTE = Z.COD_UNIDADE_EXECUTANTE_PAI     
      WHERE Z.UN_EXECUTANTE IS NOT NULL
      ORDER BY Y.NOM_INSTITUTO, Z.UN_EXECUTANTE;
------------------------------------------------------------------------
SELECT *
 FROM UNIDADE_EXECUTANTE ue
 WHERE ue.cod_unidade_executante_pai = 3
 AND ue.idf_ativo = 0;
       

-------------------------------------------------------------------------
-- Custo dos materiais Gastos, com base no custo m�dio
SELECT DISTINCT --OS.NUM_ORDEM,
                OS.NUM_ORDEM_SERVICO || '/' || OS.ANO_ORDEM_SERVICO NUM_OS,
                OS.COD_CENCUSTO,
               -- TOS.COD_UNIDADE_EXECUTANTE,
                IRM.DTA_MOV_CONTABIL DTA_OCORRENCIA,
                UE.NOM_UNIDADE_EXECUTANTE,
          --      0 QTD_OS_CONCLUIDA,
           --     0 QTD_HOR_APONT,
           --     0 VLR_SERVICO_EXTERNO,

                SUM(IRM.VLR_PONDERADO * IRM.QTD_FORNE_RECEBIDA *
                    DECODE(RM.IDF_TIPO_REQUISICAO, 0, 1, 1, -1, 0)) VLR_MATERIAL,

           --    0 VLR_FATURADO,
           --     GC.COD_GRUPO,
                GC.DSC_GRUPO
             --   GC.ORD_IMPRESSAO
  FROM ITEM_REQUISICAO_MATERIAL IRM,
       REQUISICAO_MATERIAL RM,
       COMPLEMENTO_REQUISICAO CR,
       TRIAGEM_ORDEM_SERVICO TOS,
       ORDEM_SERVICO OS,
       CENTRO_CUSTO CC,
       GRUPO_CENCUSTO GC,
       (SELECT COD_UNIDADE_EXECUTANTE, NOM_UNIDADE_EXECUTANTE
          FROM UNIDADE_EXECUTANTE
         START WITH COD_UNIDADE_EXECUTANTE IN (123, 124, 125, 126, 127, 137, 141, 131, 192, 129, 130)
        CONNECT BY PRIOR COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI) UE

 WHERE IRM.DTA_MOV_CONTABIL BETWEEN TO_DATE('01/01/2022', 'DD/MM/YYYY') AND    TO_DATE('31/12/2022', 'DD/MM/YYYY')

   AND IRM.NUM_REQUISICAO = RM.NUM_REQUISICAO
   AND IRM.ANO_REQUISICAO_MATERIAL = RM.ANO_REQUISICAO_MATERIAL
   AND RM.ANO_REQUISICAO_MATERIAL = CR.ANO_REQUISICAO_MATERIAL
   AND RM.NUM_REQUISICAO = CR.NUM_REQUISICAO
   AND CR.IDF_TIPO_DOCUMENTO = 17
   AND CR.NUM_DOCUMENTO = TOS.NUM_TRIAGEM_OS
   AND TOS.NUM_ORDEM = OS.NUM_ORDEM
   AND OS.COD_CENCUSTO = CC.COD_CENCUSTO
   AND CC.COD_GRUPO = GC.COD_GRUPO(+)
   AND TOS.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE
  -- AND TOS.SEQ_GRUPO_ESTATISTICA = 5

  -- AND OS.COD_CENCUSTO IN ('CACK00013', 'CACN0001X', 'CACK00049', 'CACL00019','CACN04014')

 GROUP BY OS.NUM_ORDEM,
          OS.NUM_ORDEM_SERVICO,
          OS.ANO_ORDEM_SERVICO,
          OS.COD_CENCUSTO,

          TOS.COD_UNIDADE_EXECUTANTE,
          IRM.DTA_MOV_CONTABIL,
          UE.NOM_UNIDADE_EXECUTANTE,

          GC.COD_GRUPO,
          GC.DSC_GRUPO,
          GC.ORD_IMPRESSAO;
---------------------------------------------------------------
----------------------------------------------------------------------
 -- Servi�o externo
SELECT DISTINCT OS.NUM_ORDEM,
                OS.NUM_ORDEM_SERVICO || '/' || OS.ANO_ORDEM_SERVICO NUM_OS,
                OS.COD_CENCUSTO,
                TOS.COD_UNIDADE_EXECUTANTE,
                DF.DTA_EMISSAO     DTA_OCORRENCIA,
                UE.NOM_UNIDADE_EXECUTANTE,

                0 QTD_OS_CONCLUIDA,
                0 QTD_HOR_APONT,
                DF.VLR_DOCUMENTO VLR_SERVICO_EXTERNO,
                0   VLR_MATERIAL,
                AGS.VLR_FATURADO,
                GC.COD_GRUPO,
                GC.DSC_GRUPO,
                GC.ORD_IMPRESSAO

  FROM DOCUMENTO_FINANCEIRO        DF,
       AGENDA_AUT_ENTREGA_SERVICO  AGS,
       AUTORIZACAO_ENTREGA_SERVICO AES,
       COTACAO_PEDIDO_SERVICO      CPS,

       PEDIDO_SERVICO        PS,
       TRIAGEM_ORDEM_SERVICO TOS,
       ORDEM_SERVICO         OS,

       CENTRO_CUSTO   CC,
       GRUPO_CENCUSTO GC,

       (SELECT COD_UNIDADE_EXECUTANTE, NOM_UNIDADE_EXECUTANTE
          FROM UNIDADE_EXECUTANTE
         START WITH COD_UNIDADE_EXECUTANTE IN (2,5,6,7,8,9,11,22,70)
        CONNECT BY PRIOR COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI) UE

 WHERE DF.DTA_HOR_LANCAMENTO BETWEEN TO_DATE('01/01/2015', 'DD/MM/YYYY') AND       TO_DATE('31/12/2020', 'DD/MM/YYYY')
   AND DF.NUM_DOC_FINANCEIRO = AGS.NUM_DOC_FINANCEIRO
   AND AGS.NUM_AUT_ENTREGA_SERVICO = AES.NUM_AUT_ENTREGA_SERVICO
   AND AES.NUM_COTACAO_SERVICO = CPS.NUM_COTACAO_SERVICO
   AND CPS.NUM_PEDIDO_SERVICO = PS.NUM_PEDIDO_SERVICO
   AND PS.NUM_TRIAGEM_OS = TOS.NUM_TRIAGEM_OS
   AND TOS.NUM_ORDEM = OS.NUM_ORDEM
   AND OS.COD_CENCUSTO = CC.COD_CENCUSTO
   AND CC.COD_GRUPO = GC.COD_GRUPO(+)
   AND TOS.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE
   AND OS.COD_CENCUSTO IN ('CACK00013', 'CACN0001X', 'CACK00049', 'CACL00019','CACN04014')
