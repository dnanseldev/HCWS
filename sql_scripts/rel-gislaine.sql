 WITH CUSTO_BASE AS (
           SELECT CMM.COD_CENCUSTO
                 ,CMM.NUM_MES
                 ,CMM.COD_MATERIAL
                 ,CMM.VLR_TOTAL_CONSUMO
                 ,AL.IDF_CLASSE               
           FROM CONSUMO_MENSAL_MATERIAL CMM
                JOIN MATERIAL M ON M.COD_MATERIAL = CMM.COD_MATERIAL
                JOIN GRUPO G ON G.COD_GRUPO = M.COD_GRUPO
                JOIN ALINEA AL ON AL.COD_ALINEA = G.COD_ALINEA
                    AND AL.IDF_CLASSE NOT IN (4,5)
           WHERE 1 = 1
 AND CMM.DTA_REFERENCIA BETWEEN to_date('01/01/2021', 'DD/MM/YYYY') AND to_date('01/02/2021', 'DD/MM/YYYY'))
 
 ,CUSTO_FINAL AS (
   SELECT CB.COD_CENCUSTO           
         ,CASE CB.NUM_MES
          WHEN 1 THEN 'JANEIRO'
          WHEN 2 THEN 'FEVEREIRO'
          WHEN 3 THEN 'MARÇO'
          WHEN 4 THEN 'ABRIL'
          WHEN 5 THEN 'MAIO'
          WHEN 6 THEN 'JUNHO'
          WHEN 7 THEN 'JULHO'
          WHEN 8 THEN 'AGOSTO'
          WHEN 9 THEN 'SETEMBRO'
          WHEN 10 THEN 'OUTUBRO'
          WHEN 11 THEN 'NOVEMBRO'
          WHEN 12 THEN 'DEZEMBRO'
      END MES          
           ,ROUND( SUM(DECODE(CB.IDF_CLASSE,1,VLR_TOTAL_CONSUMO,0)), 2) MATERIAL_CONSUMO
           ,ROUND( SUM(DECODE(CB.IDF_CLASSE,2,VLR_TOTAL_CONSUMO,0)), 2) MEDICAMENTO
           ,ROUND( SUM(DECODE(CB.IDF_CLASSE,3,VLR_TOTAL_CONSUMO,0)), 2) CONSUMO_DURAVEL
           ,ROUND( SUM(VLR_TOTAL_CONSUMO), 2) TOTAL_CONSUMO
      FROM CUSTO_BASE CB
      GROUP BY CB.COD_CENCUSTO,
               CB.NUM_MES
       ORDER BY NUM_MES )
       
     SELECT * FROM CUSTO_FINAL;
     ------------------------------------
                 --APONTAMENTO
           SELECT RM.NUM_REQUISICAO
                  ,RM.ANO_REQUISICAO_MATERIAL
                  ,IRM.COD_MATERIAL
                  ,RM.DTA_REQUISICAO                  
                  ,RM.COD_CENCUSTO_SOLICITANTE
                  ,RM.COD_CENCUSTO_ATENDENTE
                  ,RM.DTA_ATENDIMENTO
                  ,RM.COD_PACIENTE                 
                  ,CASE RM.IDF_SUB_TIPO_REQUI
                     WHEN 0 THEN 'PARA_PACIENTE'
                     WHEN 1 THEN 'REPOSICAO_CENTRO_CUSTO'
                     WHEN 2 THEN 'MATERIAL_PROGRAMADO'
                     WHEN 3 THEN 'MATERIAL_ENGENHARIA'
                     WHEN 4 THEN 'ATENDIMENTO_SM'
                     WHEN 5 THEN 'ACERTO_ESTOQUE'
                     WHEN 6 THEN 'COMPRAS_DEPARTAMENTO'
                     WHEN 7 THEN 'REQUISICAO_CONSIGNACAO'
                     WHEN 8 THEN 'REQUISICAO_CEMB'
                     WHEN 9 THEN 'REQUISICAO_OS'
                     WHEN 10 THEN 'ENTREGA_MAT_PERMAMENTE'
                     WHEN 11 THEN 'RECUPERACAO_MEDICAMENTOS'
                     WHEN 12 THEN 'RACIONAMENTO'
                     WHEN 13 THEN 'COVID-19-EPI'
                    END TIPO_REQUISICAO    
                  ,IRM.QTD_FORNE_RECEBIDA,
                  M.VLR_ULTIMA_COMPRA,
                  M.VLR_CUSTO_MEDIO 
           FROM REQUISICAO_MATERIAL RM
           JOIN ITEM_REQUISICAO_MATERIAL IRM ON IRM.NUM_REQUISICAO = RM.NUM_REQUISICAO
                AND IRM.ANO_REQUISICAO_MATERIAL = RM.ANO_REQUISICAO_MATERIAL
           JOIN MATERIAL M ON M.COD_MATERIAL = IRM.COD_MATERIAL                 
           WHERE 1 = 1
           AND RM.COD_CENCUSTO_SOLICITANTE = 'CAAA00024'
           AND RM.DTA_REQUISICAO BETWEEN TO_DATE('01/01/2021', 'DD/MM/YYYY') AND TO_DATE('01/02/2021', 'DD/MM/YYYY');
