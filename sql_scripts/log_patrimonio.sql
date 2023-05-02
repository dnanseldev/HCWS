SELECT *
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio = 633
 AND bp.cod_tipo_patrimonio = 59;
 
 --42536/2021
 SELECT *
  FROM Ordem_Servico os
  WHERE os.num_ordem_servico = 54706 --42536 54706
  AND os.ano_ordem_servico = 2021;
  
  select * from GENERICO.ORDEM_SERVICO t
where t.num_bem = 220518;
------------------------------------
/*
  IF (NVL( :NEW.NUM_SERIE, '0' ) <> NVL( :OLD.NUM_SERIE, '0') ) THEN
    INSERT INTO LOG_PATRIMONIO(DTA_HOR_LOG, DSC_CHAVE, NOM_TABELA, IDF_OPERACAO, NUM_USER_LOG, NOM_COLUNA, CTU_ANTERIOR)
    VALUES(SYSDATE , TO_CHAR(:old.NUM_BEM), 'BEM_PATRIMONIAL', 'U', v_num_user, 'NUM_SERIE', TO_CHAR(:old.NUM_SERIE));
  END IF;
*/
 
--NB: 220518
SELECT lm.dta_hor_log,
       lm.num_user_log,
       u.nom_usuario||' '||u.sbn_usuario nom_usuario,
       lm.idf_operacao,
       lm.nom_tabela,
       lm.nom_coluna,
       lm.dsc_chave,
       lm.ctu_anterior
 FROM LOG_PATRIMONIO lm
 JOIN usuario u ON u.num_user_banco = lm.num_user_log
 WHERE lm.nom_tabela = 'BEM_PATRIMONIAL'
 AND lm.idf_operacao = 'U'
 AND lm.dsc_chave = '220518'
-- AND lm.nom_coluna = 'NUM_SERIE';
ORDER BY lm.dta_hor_log DESC;
