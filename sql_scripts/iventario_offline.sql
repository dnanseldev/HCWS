 /*Divergências com chaves duplicadas*/
 SELECT *
  FROM (SELECT (SELECT COUNT(*)
                  FROM EXPORTACAO_INVENTARIO EI2
                 WHERE EI2.SEQ_EXPORTACAO_INVENTARIO <>
                       EI.SEQ_EXPORTACAO_INVENTARIO
                   AND EI2.NUM_BEM = EI.NUM_BEM
                   AND EI2.DTA_EXCLUSAO_LOGICA IS NULL
                   AND EI2.DTA_HOR_INTEGRACAO IS NULL) CHAVE_DUPLICADA,                               
                   
                EI.SEQ_EXPORTACAO_INVENTARIO,
                EI.NUM_BEM,
                EI.COD_TIPO_PATRIMONIO,
                EI.COD_TIPO_PATRIMONIO_NOVO,
                EI.NUM_PATRIMONIO,
                EI.DSC_TIPO_PATRIMONIO,
                EI.DSC_BEM,
                EI.NUM_PATRIMONIO_NOVO,
                EI.DSC_TIPO_PATRIMONIO_NOVO,
                EI.NUM_PATRIMONIO || '-' || EI.DSC_TIPO_PATRIMONIO PATRIMONIO_ANTIGO,
                EI.NUM_PATRIMONIO_NOVO || '-' || EI.DSC_TIPO_PATRIMONIO_NOVO PATRIMONIO_NOVO,
                EI.IDF_ESTADO,
                EI.COD_MARCA,
                EI.DSC_MARCA,
                EI.NUM_SERIE,
                EI.DSC_MODELO,
                EI.COD_CENCUSTO,
                EI.NOM_CENCUSTO,
                EI.DTA_HOR_CADASTRO_INVENT,
                EI.DTA_HOR_EXPORTACAO,
                EI.COD_LOCALIZACAO,
                EI.DSC_LOCALIZACAO,
                EI.DSC_LOCALIZACAO_ESPEC,
                EI.NOM_USUARIO_CADASTRO
          FROM EXPORTACAO_INVENTARIO EI
         WHERE EI.DTA_EXCLUSAO_LOGICA IS NULL
           AND EI.DTA_HOR_INTEGRACAO IS NULL) X
 WHERE X.CHAVE_DUPLICADA > 0
 ORDER BY X.NUM_BEM;
 -------------------------------------------
SELECT *
 FROM EXPORTACAO_INVENTARIO ei;
 
 SELECT *
  FROM EXPORTACAO_INVENTARIO_OCOR EIO;
