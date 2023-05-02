--46831/2022

SELECT *
 FROM ordem_servico os
 WHERE os.num_ordem_servico = 61714 
 AND os.ano_ordem_servico = 2022;
 
 select ROWID,t.* from GENERICO.HISTORICO_ORDEM_SERVICO t
where t.num_ordem = 1360671
ORDER BY 3 DESC;

SELECT *
 FROM AUTORIZACAO_ENTREGA a
 WHERE a.num_user_emissao = 66827;
