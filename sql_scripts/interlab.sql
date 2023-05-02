WITH NB_LIST AS
 (SELECT C.NUM_BEM
    FROM CENTRO_CUSTO_BEM_PATRIMONIAL C
   WHERE C.COD_CENCUSTO = 'CACK00104'
     AND C.DTA_FIM IS NULL)
     
 SELECT BP.NUM_BEM,
        TIE.NOM_TIPO_IMAGEM_EQUIPAMENTO EQUIPAMENTO,
        OST.NOM_ABREVIADO_PESQUISA      TIPO_EQUIPAMENTO,
        M.NOM_MARCA,
        O.DSC_MODELO,
        O.NUM_SERIE
   FROM BEM_PATRIMONIAL_TP_IMAGEM_EQUI BP
   JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE
     ON BP.SEQ_TIPO_IMAGEM_EQUIPAMENTO = TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO
   JOIN GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OST
     ON OST.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO = TIE.SEQ_CODIGO_SISTEMA_ORIGEM
   JOIN BEM_PATRIMONIAL O
     ON O.NUM_BEM = BP.NUM_BEM
   LEFT JOIN MARCA M
     ON M.COD_MARCA = O.COD_MARCA
  WHERE BP.IDF_ATIVO = 0
  ORDER BY EQUIPAMENTO;
 -----------------------------------------------------
  SELECT
        TIE.NOM_TIPO_IMAGEM_EQUIPAMENTO EQUIPAMENTO,
        COUNT(*) QTD      
  FROM BEM_PATRIMONIAL_TP_IMAGEM_EQUI BP
  JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE USING(SEQ_TIPO_IMAGEM_EQUIPAMENTO)  
  JOIN GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OST
       ON OST.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO = TIE.SEQ_CODIGO_SISTEMA_ORIGEM
  JOIN BEM_PATRIMONIAL USING(NUM_BEM) 
  WHERE BP.IDF_ATIVO = 0
  GROUP BY TIE.NOM_TIPO_IMAGEM_EQUIPAMENTO
  ORDER BY EQUIPAMENTO; 

     
 
 
 
 
 
