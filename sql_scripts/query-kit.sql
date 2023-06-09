 SELECT *
 FROM (SELECT A.*,
              ROWNUM AS RNUM FROM( 
 SELECT B.SEQ_LACRE_REPOSITORIO_ITENS, 
        NVL(TO_CHAR(J.NUM_PATRIMONIO),'SEM NÚMERO') || ' / ' || K.DSC_TIPO_PATRIMONIO PATRIMONIO,  
        A.SEQ_LACRE_REPOSITORIO, 
        A.SEQ_REPOSITORIO, 
        I.DSC_IDENTIFICACAO, 
        NVL(H.DSC_ALINEA, 
        (SELECT X.DSC_ALINEA 
            FROM ALINEA X 
            WHERE X.COD_ALINEA = C.COD_ALINEA)) DSC_ALINEA, 
        NVL(B.COD_MATERIAL, D.COD_MATERIAL) COD_MATERIAL, 
        NVL(D.NOM_MATERIAL, C.DSC_MATERIAL) NOM_MATERIAL, 
        C.QTD_NECESSARIA, 
            (SELECT B.QTD_DISPONIVEL - NVL(SUM(X.QTD_UTILIZADA),0) 
            FROM LACRE_REPOSIT_UTILIZACAO X 
            WHERE X.SEQ_LACRE_REPOSITORIO_ITENS = 
            B.SEQ_LACRE_REPOSITORIO_ITENS) 
            QTD_VENCENDO, 
        NVL(B.NUM_LOTE_FABRICANTE, E.NUM_LOTE_FABRICANTE) LOTE_FABRICANTE, 
        NVL(B.DTA_VALIDADE_LOTE, E.DTA_VALIDADE_LOTE) DTA_VALIDADE_LOTE 
 FROM LACRE_REPOSITORIO          A, 
    LACRE_REPOSITORIO_ITENS    B, 
    ITENS_LISTA_CONTROLE       C, 
    MATERIAL                   D, 
    LOTE                       E, 
    UNIDADE                    F, 
    GRUPO                      G, 
    ALINEA                     H, 
    REPOSITORIO_LISTA_CONTROLE I, 
    BEM_PATRIMONIAL            J, 
    TIPO_PATRIMONIO            K, 
    TIPO_REPOSITORIO_LST_CONTROLE L
 WHERE A.SEQ_LACRE_REPOSITORIO = B.SEQ_LACRE_REPOSITORIO 
    AND B.SEQ_ITENS_LISTA_CONTROLE = C.SEQ_ITENS_LISTA_CONTROLE 
    AND C.COD_MATERIAL = D.COD_MATERIAL(+) 
    AND B.NUM_LOTE = E.NUM_LOTE(+) 
    AND D.COD_UNIDADE = F.COD_UNIDADE(+) 
    AND D.COD_GRUPO = G.COD_GRUPO(+) 
    AND G.COD_ALINEA = H.COD_ALINEA(+) 
    AND A.SEQ_REPOSITORIO = I.SEQ_REPOSITORIO 
    AND I.NUM_BEM = J.NUM_BEM(+) 
    AND J.COD_TIPO_PATRIMONIO = K.COD_TIPO_PATRIMONIO(+) 
    AND L.SEQ_TIP_REPOSIT_LST_CONTROL = I.SEQ_TIP_REPOSIT_LST_CONTROL 
 AND I.IDF_ATIVO = 'S' 
 AND (TRUNC(NVL(B.DTA_VALIDADE_LOTE, E.DTA_VALIDADE_LOTE)) <  TRUNC(SYSDATE + 131) 
 AND NVL((SELECT B.QTD_DISPONIVEL - SUM(X.QTD_UTILIZADA) 
         FROM LACRE_REPOSIT_UTILIZACAO X 
        WHERE X.SEQ_LACRE_REPOSITORIO_ITENS =  B.SEQ_LACRE_REPOSITORIO_ITENS), 
       B.QTD_DISPONIVEL) > 0) 
 AND I.SEQ_REPOSITORIO = 488 
    AND I.SEQ_LISTA_CONTROLE IN 
       (SELECT X.SEQ_LISTA_CONTROLE 
       FROM LISTA_CONTROLE X 
 WHERE X.COD_INSTITUTO = 7) 
 AND (SELECT B.QTD_DISPONIVEL - NVL(SUM(X.QTD_UTILIZADA), 0) 
 FROM LACRE_REPOSIT_UTILIZACAO X 
 WHERE X.SEQ_LACRE_REPOSITORIO_ITENS = B.SEQ_LACRE_REPOSITORIO_ITENS) > 0 
AND A.SEQ_LACRE_REPOSITORIO = (SELECT MAX(X.SEQ_LACRE_REPOSITORIO) FROM LACRE_REPOSITORIO X WHERE X.SEQ_REPOSITORIO = i.seq_repositorio) 
 AND L.SEQ_TIP_REPOSIT_LST_CONTROL = 4 

  ORDER BY H.DSC_ALINEA , NVL(D.NOM_MATERIAL, C.DSC_MATERIAL) ) A 
 WHERE ROWNUM <= 25 ) WHERE RNUM >= 1;