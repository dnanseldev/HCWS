 INSERT INTO GENERICO.HISTORICO_ORDEM_SERVICO
  (NUM_ORDEM,
   DTA_HOR_HISTORICO,
   IDF_PRIORIZADO,
   NUM_USER_LOG,
   COD_SITUACAO_OS,
   COD_UNIDADE_EXECUTANTE,
   DSC_ANOTACAO)
SELECT  os.num_ordem
       ,SYSDATE
       ,3
       ,fc_num_user_banco
       ,3
       ,os.cod_unidade_executante
       ,'CIA'
 FROM ordem_servico os
 WHERE 1 = 1
 AND os.dta_criacao_os >= SYSDATE - 15
 --UE
 --AND os.cod_unidade_executante in (15, 16, 17, 19, 20, 23, 24, 51, 52, 79, 132, 128, 135, 136, 183, 184, 185, 186, 140, 193, 139) 
 --CAMPUS
 and os.cod_unidade_executante in (1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14, 22, 45, 46, 48, 53, 54, 56, 57, 58, 59, 62, 64, 68, 70, 101, 123, 124, 125, 126, 127, 129, 130, 131, 133, 134, 137, 141, 155, 156, 157, 158, 159, 180, 187, 188, 189, 192, 194, 195, 196, 197, 198, 199, 200, 219, 220, 225, 226)
 AND os.cod_situacao_os = 0;
