--66506/2020,
79674,2020,
51424,2020,
81088,2020,
78665,2020,
59596,2020,
72452,2020,
77772,2020,17032/2021,68377/2021

;
SELECT *
 FROM Ordem_Servico os
 WHERE os. num_ordem_servico
 IN (17032, 68377)
   AND os.ano_ordem_servico = 2021;
---------------------------------------------
SELECT os.num_ordem
      ,SYSDATE DTA_HOR_HISTORICO
      ,3 IDF_PRIORIZADO
      ,66827 NUM_USER_LOG
      ,5 COD_SITUACAO_OS
      ,189 COD_UNIDADE_EXECUTANTE
      , 'FINALIZADO A PEDIDO DA ROSANGELA HITOMI' DSC_ANOTACAO
 FROM Ordem_Servico os
 WHERE os. num_ordem_servico
 IN (17032, 68377)
   AND os.ano_ordem_servico = 2021;
   
  select * from GENERICO.HISTORICO_ORDEM_SERVICO t
where t.num_ordem = 1173452;
