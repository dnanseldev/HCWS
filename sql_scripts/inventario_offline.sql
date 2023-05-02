/*Carga dados Inventário*/
SELECT
  CCBP.NUM_BEM, CCBP.COD_CENCUSTO, CCBP.COD_LOCALIZACAO, CCBP.DTA_INICIO,
  CCBP.DTA_FIM, CCBP.NUM_USER_BANCO, BP.COD_TIPO_PATRIMONIO, BP.NUM_PATRIMONIO,
  SUBSTR(UPPER(FC_NOM_BEM_PATRIMONIAL(BP.NUM_BEM)), 1, 255) DESCRICAO,
  L.DSC_LOCALIZACAO, U.NOM_USUARIO ||' '||U.SBN_USUARIO NOM_USUARIO,
  TP.DSC_TIPO_PATRIMONIO,
  (SELECT SBP.SGL_SAP_CATEGORIA FROM INTEGRA_SAP.SAP_BEM_PATRIMONIAL SBP 
   WHERE SBP.NUM_BEM = BP.NUM_BEM) SGL_SAP_CATEGORIA, 
  (SELECT NP.NUM_PATRIMONIO FROM NUMERO_PATRIMONIO NP
   WHERE NP.NUM_BEM = BP.NUM_BEM
     AND (NP.COD_TIPO_PATRIMONIO <> BP.COD_TIPO_PATRIMONIO
       OR NP.NUM_PATRIMONIO <> BP.NUM_PATRIMONIO)
     AND ROWNUM <= 1) NUM_PATRIMONIO_ANTIGO,
  (SELECT TP.DSC_TIPO_PATRIMONIO FROM NUMERO_PATRIMONIO NP, TIPO_PATRIMONIO TP
   WHERE NP.NUM_BEM = BP.NUM_BEM
     AND NP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
     AND (NP.COD_TIPO_PATRIMONIO <> BP.COD_TIPO_PATRIMONIO
       OR NP.NUM_PATRIMONIO <> BP.NUM_PATRIMONIO)
     AND ROWNUM <= 1) DSC_TIPO_PATRIMONIO_ANTIGO,

  DECODE(BP.IDF_ESTADO_BEM, 0, 'INDEFINIDO', 1, 'BOM', 2, 'REGULAR', 3, 'MAU', 4, 'SUCATA') IDF_ESTADO_BEM,
  BP.CPL_LOCALIZACAO

FROM CENTRO_CUSTO_BEM_PATRIMONIAL CCBP,
     BEM_PATRIMONIAL BP,
     TIPO_PATRIMONIO TP,
     LOCALIZACAO L,
     USUARIO U
     
WHERE 1 = 1
  AND CCBP.DTA_FIM IS NULL
  AND CCBP.COD_CENCUSTO = 'CCEA0001X'
  AND CCBP.COD_LOCALIZACAO = 4169
  AND CCBP.NUM_BEM = BP.NUM_BEM
  AND CCBP.COD_LOCALIZACAO = L.COD_LOCALIZACAO
  AND U.NUM_USER_BANCO = CCBP.NUM_USER_BANCO
  AND BP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
  AND EXISTS(SELECT 1 FROM NUMERO_PATRIMONIO NP
             WHERE NP.NUM_PATRIMONIO = BP.NUM_PATRIMONIO
               AND NP.COD_TIPO_PATRIMONIO = BP.COD_TIPO_PATRIMONIO
               AND NP.NUM_BEM = BP.NUM_BEM)
  AND EXISTS(SELECT 1 FROM INVENT_PATRIMONIO_LOCAL IPL
             WHERE IPL.SEQ_INVENT_PATRIMONIO_LOCAL = 85
               AND IPL.COD_CENCUSTO = CCBP.COD_CENCUSTO
               AND IPL.COD_LOCALIZACAO = CCBP.COD_LOCALIZACAO
               AND IPL.SEQ_INVENT_PATRIMONIO_LOCAL = CCBP.SEQ_INVENT_PATRIMONIO_LOCAL
               AND IPL.DTA_FINALIZACAO IS NULL)
ORDER BY BP.NUM_PATRIMONIO;
---------------------------------
SELECT

  O.SEQ_INVENT_PATRIMON_OCORRENCIA, U.NOM_USUARIO || ' ' || U.SBN_USUARIO USUARIO,
  SUBSTR(TO_CHAR(NP.NUM_PATRIMONIO) || '-' || 
  UPPER(FC_NOM_BEM_PATRIMONIAL(NP.NUM_BEM)), 1, 255) PATRIMONIO,
  O.DSC_OCORRENCIA

FROM INVENT_PATRIMONIO_OCORRENCIA O,
     USUARIO U,
     NUMERO_PATRIMONIO NP

WHERE O.SEQ_INVENT_PATRIMONIO_LOCAL = 85
  AND O.NUM_USER_OCORRENCIA = U.NUM_USER_BANCO
  AND O.NUM_PATRIMONIO = NP.NUM_PATRIMONIO(+)
  AND O.COD_TIPO_PATRIMONIO = NP.COD_TIPO_PATRIMONIO(+)
ORDER BY O.SEQ_INVENT_PATRIMON_OCORRENCIA;
---------------------------------
/*Tabelas de inventário offline*/
SELECT * FROM
 EXPORTACAO_INVENTARIO ei
 WHERE ei.cod_cencusto = 'CACC04036'
 AND ei.num_bem IS NULL;
 
 
SELECT ei.num_bem, COUNT(*) FROM
 EXPORTACAO_INVENTARIO ei
 WHERE 1 = 1
 AND ei.num_bem IS NOT NULL
 GROUP BY ei.num_bem
 HAVING COUNT(*) > 1;
-------------------------------------
/*Patrimônios duplicados*/ 
 SELECT ei.num_bem,
        ei.dta_hor_cadastro_invent,
        ei.dta_hor_exportacao, ei.*
  FROM EXPORTACAO_INVENTARIO ei
  WHERE EXISTS 
 (SELECT *
   FROM (SELECT EI.NUM_BEM
           FROM EXPORTACAO_INVENTARIO EI
          WHERE 1 = 1
            AND EI.NUM_BEM IS NOT NULL
          GROUP BY EI.NUM_BEM
         HAVING COUNT(*) > 1) EX
         WHERE EX.NUM_BEM = ei.num_bem)
         ORDER BY ei.num_bem, ei.dta_hor_cadastro_invent;
         

       
  ---------------------------------------------------------
  /*Equipamentos com chapas diferentes Aprimorado*/ 
 WITH PAT_NOVOS_DUPLICADOS AS
  (SELECT *
     FROM (SELECT EI.NUM_BEM
             FROM EXPORTACAO_INVENTARIO EI
            WHERE EI.NUM_BEM IS NOT NULL
            GROUP BY EI.NUM_BEM
           HAVING COUNT(*) > 1) X
    WHERE NOT EXISTS (SELECT *
             FROM (SELECT EI.NUM_BEM,
                          EI.NUM_PATRIMONIO_NOVO,
                          EI.COD_TIPO_PATRIMONIO_NOVO
                     FROM EXPORTACAO_INVENTARIO EI
                    WHERE EI.NUM_BEM IS NOT NULL
                    GROUP BY EI.NUM_BEM,
                             EI.NUM_PATRIMONIO_NOVO,
                             EI.COD_TIPO_PATRIMONIO_NOVO
                   HAVING COUNT(*) > 1) EX
            WHERE EX.NUM_BEM = X.NUM_BEM))
 
 SELECT EI.NUM_BEM,
        EI.NUM_PATRIMONIO || '-' || EI.DSC_TIPO_PATRIMONIO PATRIMONIO_ANTIGO,
        EI.NUM_PATRIMONIO_NOVO || '-' || EI.DSC_TIPO_PATRIMONIO_NOVO PATRIMONIO_NOVO,
        EI.COD_CENCUSTO,
        EI.DTA_HOR_CADASTRO_INVENT,
        EI.DTA_HOR_EXPORTACAO,
        EI.DSC_LOCALIZACAO,
        EI.NOM_USUARIO_CADASTRO
   FROM EXPORTACAO_INVENTARIO EI
 
  WHERE EXISTS (SELECT 1 FROM PAT_NOVOS_DUPLICADOS D WHERE D.NUM_BEM = EI.NUM_BEM)
  ORDER BY EI.NUM_BEM, EI.DTA_HOR_CADASTRO_INVENT DESC;
  
      --Duplicados mesmo patrimônio novo
   WITH duplicados AS (  
     SELECT ei.num_bem,
            ei.num_patrimonio,
            ei.cod_tipo_patrimonio,
            ei.num_patrimonio_novo,
            ei.cod_tipo_patrimonio_novo,
            ei.cod_cencusto
      FROM EXPORTACAO_INVENTARIO EI
      WHERE EXISTS 
     (SELECT *
     FROM (SELECT EI.NUM_BEM,
            EI.NUM_PATRIMONIO_NOVO,
            EI.DSC_TIPO_PATRIMONIO_NOVO,
            COUNT(*)
           FROM EXPORTACAO_INVENTARIO EI
          WHERE 1 = 1
            AND EI.NUM_BEM IS NOT NULL
          GROUP BY EI.NUM_BEM,
                   EI.NUM_PATRIMONIO_NOVO,
                   EI.DSC_TIPO_PATRIMONIO_NOVO
         HAVING COUNT(*) > 1) x
         WHERE x.NUM_BEM = ei.num_bem)
         ORDER BY ei.num_bem)
       
         SELECT *
          FROM duplicados;     
 
         
------------------------------------------------------
----General queries
SELECT * 
    FROM EXPORTACAO_INVENTARIO_OCOR o
    WHERE o.num_bem = 16191;

SELECT *
 FROM centro_custo_bem_patrimonial c
 WHERE c.cod_cencusto = 'CACC04036'
 AND c.dta_fim IS NULL;
 
 SELECT *
  FROM INVENT_PATRIMONIO_LOCAL;
  
  SELECT *
  
   
  
