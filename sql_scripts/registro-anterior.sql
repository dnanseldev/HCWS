SELECT  os.num_ordem
        ,os.cod_cencusto
        ,LAG(os.num_ordem,1,NULL) OVER(ORDER BY 1) coluna_posterior
        ,LEAD(os.num_ordem,1,NULL) OVER(ORDER BY 1) coluna_anterior
       
       --,os.*
 FROM Ordem_Servico os
 WHERE os.dta_criacao_os >= TRUNC(SYSDATE)
 
 ORDER BY 1 DESC;
