DECLARE
   l_num_ordem         Ordem_Servico.Num_Ordem%TYPE;
   CURSOR tcOS IS
     SELECT os.num_ordem FROM Ordem_Servico os
   WHERE os.num_ordem_servico IN (
     54177,46091,56051   
 )
 AND os.ano_ordem_servico = 2020
 AND os.cod_situacao_os NOT IN (4,5);
   
BEGIN
    OPEN tcOS;
      LOOP
         FETCH tcOS INTO l_num_ordem;
         EXIT WHEN tcOS%NOTFOUND;
         dbms_output.put_line(l_num_ordem);
         
         --Transactions
         insert into GENERICO.HISTORICO_ORDEM_SERVICO (NUM_ORDEM, DTA_HOR_HISTORICO, IDF_PRIORIZADO, NUM_USER_LOG, COD_SITUACAO_OS, COD_UNIDADE_EXECUTANTE, DSC_ANOTACAO)
         values (l_num_ordem, sysdate, 3, fc_num_user_banco, 5, 189,'Encerrado a pedido da CEQ');
      END LOOP;
    CLOSE tcOS;
    COMMIT;    
END;
