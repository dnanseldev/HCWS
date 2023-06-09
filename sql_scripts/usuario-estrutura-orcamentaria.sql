select * from USUARIO_TIPO_AQUISICAO t
WHERE t.num_user_banco = 62109;
--FOR UPDATE;
--74671
--62109
SELECT DISTINCT ESTOQUE.FCN_INST_ONERACAO(X.COD_INSTITUICAO, X.COD_ESTRUTURA) COD_INSTITUICAO,
       Y.NOM_INSTITUICAO, Y.NOM_FANTASIA
FROM USUARIO_ESTRUTURA_ORCAMENTARIA X, V_INSTITUICAO_COMPRAS Z, V_INSTITUICAO_ORDEM_SERVICO Y
WHERE NUM_USER_BANCO = 74671--FC_NUM_USER_BANCO
  AND ESTOQUE.FCN_INST_ONERACAO(X.COD_INSTITUICAO, X.COD_ESTRUTURA) = Z.COD_INSTITUICAO
  AND Z.COD_INSTITUICAO = Y.COD_INSTITUICAO(+)
  AND Z.COD_INST_SIST_CC = 1;
