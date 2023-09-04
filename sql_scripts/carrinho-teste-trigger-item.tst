PL/SQL Developer Test script 3.0
38
-- Created on 18/08/2023 by DAANSELMO 
/*Teste de validação da trigger*/
------Usar em editor de test  para poder debugar------------------------
DECLARE
     L_NUM_REQUISICAO                  ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.NUM_REQUISICAO%TYPE;                   
     L_ANO_REQUISICAO_MATERIAL         ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.ANO_REQUISICAO_MATERIAL%TYPE       :=      EXTRACT(YEAR FROM SYSDATE);
     L_COD_MATERIAL                    ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.COD_MATERIAL%TYPE                  :=      '58100374';
     L_SEQ_LACRE_REPOSITORIO           ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.SEQ_LACRE_REPOSITORIO%TYPE         :=       58382;
     L_SEQ_LACRE_REPOSITORIO_ITENS     ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.SEQ_LACRE_REPOSITORIO_ITENS%TYPE   :=       3710302;
     L_QTD_REQUISI_DEVOLVIDA           ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.QTD_REQUISI_DEVOLVIDA%TYPE         :=       1; 
     L_QTD_FORNE_RECEBIDA              ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.QTD_FORNE_RECEBIDA%TYPE            :=       1;
     L_VLR_PONDERADO                   ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.VLR_PONDERADO%TYPE                 :=       3.712138;
     L_IDF_TIPO_MATERIAL               ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.IDF_TIPO_MATERIAL%TYPE             :=       0;
     L_DTA_MOV_CONTABIL                ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.DTA_MOV_CONTABIL%TYPE              :=       SYSDATE;
     L_VLR_ULTIMA_COMPRA               ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO.VLR_ULTIMA_COMPRA%TYPE             :=       3.700000;
     
BEGIN
    SELECT MAX(R.NUM_REQUISICAO)+1 INTO L_NUM_REQUISICAO
    FROM ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO R
    WHERE R.ANO_REQUISICAO_MATERIAL = EXTRACT(YEAR FROM SYSDATE);
           
    EXECUTE IMMEDIATE 'INSERT INTO ESTOQUE.ITEM_REQUISICAO_MATERIAL_REPOSITORIO (  NUM_REQUISICAO,
                                                                                   ANO_REQUISICAO_MATERIAL,
                                                                                   COD_MATERIAL,
                                                                                   SEQ_LACRE_REPOSITORIO,
                                                                                   SEQ_LACRE_REPOSITORIO_ITENS,
                                                                                   QTD_REQUISI_DEVOLVIDA,
                                                                                   QTD_FORNE_RECEBIDA,
                                                                                   VLR_PONDERADO,     
                                                                                   IDF_TIPO_MATERIAL,
                                                                                   DTA_MOV_CONTABIL,
                                                                                   VLR_ULTIMA_COMPRA )
    VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11)'
    USING L_NUM_REQUISICAO,         L_ANO_REQUISICAO_MATERIAL, L_COD_MATERIAL,    L_SEQ_LACRE_REPOSITORIO,   L_SEQ_LACRE_REPOSITORIO_ITENS,
          L_QTD_REQUISI_DEVOLVIDA,  L_QTD_FORNE_RECEBIDA,      L_VLR_PONDERADO,   L_IDF_TIPO_MATERIAL,       L_DTA_MOV_CONTABIL, 
          L_VLR_ULTIMA_COMPRA;
    COMMIT;
END;
0
0
