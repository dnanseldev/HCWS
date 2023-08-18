-- Created on 18/08/2023 by DAANSELMO 
/*Teste de validação da trigger*/
------Usar em editor de test  para poder debugar------------------------
DECLARE
     L_NUM_REQUISICAO                ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.NUM_REQUISICAO%TYPE;                   
     L_ANO_REQUISICAO_MATERIAL       ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.ANO_REQUISICAO_MATERIAL%TYPE     :=      EXTRACT(YEAR FROM SYSDATE);
     L_IDF_SOLICITANTE               ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.IDF_SOLICITANTE%TYPE             :=      66827;
     L_COD_CENCUSTO_SOLICITANTE      ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.COD_CENCUSTO_SOLICITANTE%TYPE    :=     'MATER0004'; 
     L_DTA_REQUISICAO                ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.DTA_REQUISICAO%TYPE              :=      SYSDATE;
     L_DTA_ATENDIMENTO               ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.DTA_ATENDIMENTO%TYPE             :=      SYSDATE;
     L_COD_CENCUSTO_ATENDENTE        ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.COD_CENCUSTO_ATENDENTE%TYPE      :=      'MATER0088';
     L_IDF_STATUS_REQUISICAO         ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.IDF_STATUS_REQUISICAO%TYPE       :=      2;
     L_IDF_PRIORIDADE                ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.IDF_PRIORIDADE%TYPE              :=      'N';
     L_IDF_TIPO_REQUISICAO           ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.IDF_TIPO_REQUISICAO%TYPE         :=      0;
     L_IDF_SUB_TIPO_REQUI            ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.IDF_SUB_TIPO_REQUI%TYPE          :=      1;
     L_COD_PACIENTE                  ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.COD_PACIENTE%TYPE                :=      '1600905H';
     L_SEQ_LACRE_REPOSITORIO         ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.SEQ_LACRE_REPOSITORIO%TYPE       :=      58389;
     L_SEQ_REPOSITORIO               ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.SEQ_REPOSITORIO%TYPE             :=      485;
     L_IDF_TIPO_DOCUMENTO            ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO.IDF_TIPO_DOCUMENTO%TYPE          :=      23;
BEGIN
    SELECT MAX(R.NUM_REQUISICAO)+1 INTO L_NUM_REQUISICAO
    FROM ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO R
    WHERE R.ANO_REQUISICAO_MATERIAL = EXTRACT(YEAR FROM SYSDATE);
           
    EXECUTE IMMEDIATE 'INSERT INTO ESTOQUE.REQUISICAO_MATERIAL_REPOSITORIO ( NUM_REQUISICAO,
                                                                             ANO_REQUISICAO_MATERIAL,
                                                                             IDF_SOLICITANTE,
                                                                             COD_CENCUSTO_SOLICITANTE,
                                                                             DTA_REQUISICAO,
                                                                             DTA_ATENDIMENTO,
                                                                             COD_CENCUSTO_ATENDENTE,
                                                                             IDF_STATUS_REQUISICAO,
                                                                             IDF_PRIORIDADE,
                                                                             IDF_TIPO_REQUISICAO,
                                                                             IDF_SUB_TIPO_REQUI,
                                                                             COD_PACIENTE,     
                                                                             SEQ_LACRE_REPOSITORIO,
                                                                             SEQ_REPOSITORIO,
                                                                             IDF_TIPO_DOCUMENTO )
    VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15)'
    USING L_NUM_REQUISICAO,     L_ANO_REQUISICAO_MATERIAL, L_IDF_SOLICITANTE,         L_COD_CENCUSTO_SOLICITANTE, L_DTA_REQUISICAO,
          L_DTA_ATENDIMENTO,    L_COD_CENCUSTO_ATENDENTE,  L_IDF_STATUS_REQUISICAO,   L_IDF_PRIORIDADE,           L_IDF_TIPO_REQUISICAO,
          L_IDF_SUB_TIPO_REQUI, L_COD_PACIENTE,            L_SEQ_LACRE_REPOSITORIO,   L_SEQ_REPOSITORIO,          L_IDF_TIPO_DOCUMENTO;
   COMMIT;
END;
