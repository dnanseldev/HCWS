SELECT *
 FROM unidade_executante ue
 WHERE ue.cod_unidade_executante in (16, 2, 133, 3, 53);
 
 
 SELECT *
  FROM Ordem_Servico os
  WHERE 1 = 1
  AND os.num_ordem_servico = 37823
  AND os.ano_ordem_servico = 2023;
  
select * from GENERICO.HISTORICO_ORDEM_SERVICO t
where t.num_ordem = 1454120;
