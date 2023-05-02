SELECT *
 FROM ordem_servico os
 WHERE os.num_ordem_servico = 22343
 AND os.ano_ordem_servico = 2022;
 --------------------------------
SELECT DISTINCT I.COD_ENTIDADE_GLPI,
                A.NUM_USER_BANCO,
                B.COD_CENCUSTO,
                B.COD_LOCAL,
                B.IDF_LOCALIZACAO,
                B.IDF_NETADMIN,
                B.COD_CENCUSTO || ' - ' || B.NOM_CENCUSTO NOM_CENCUSTO,
                CC.DSC_GLPI_GROUP_ID
  FROM CENTRO_CUSTO_USUARIO_PERMISSAO A, INSTITUTO I, CENTRO_CUSTO B
  LEFT JOIN GENERICO.CENTRO_CUSTO_INTEGRACAO CC
    ON CC.COD_CENCUSTO = B.COD_CENCUSTO
 WHERE A.COD_SISTEMA = 72
   AND A.IDF_ATIVO = 0
   AND I.COD_INST_SISTEMA IN (1, 80)
   AND I.COD_INSTITUTO = B.COD_INSTITUTO
   AND B.IDF_ESTOQUE = '0'
   AND B.IDF_ATIVO = 'S'
   AND A.NUM_USER_BANCO = 74524 --fc_num_user_banco
   AND A.COD_CENCUSTO = B.COD_CENCUSTO
 ORDER BY COD_CENCUSTO;
  --CEDB00016
  --DAM-42
  SELECT *
   FROM centro_custo cc
   WHERE cc.cod_cencusto = 'CEDB00016';