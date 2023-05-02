SELECT *
 FROM agenda_cirurgia ac
 WHERE 1 = 1
AND ac.cod_paciente = '0596107B' 
--AND ac.seq_agenda_cirurgia = 612099;
--614793
;
----------------------------------------------------
SELECT *
 FROM solicitacao_insumo s
 WHERE s.cod_paciente = '1693916A'; 
 
 
select * from ESTOQUE.SOLICITACAO_INSUMO_ITEM t
where t.seq_solicitacao_insumo = 59885
--AND t.seq_solicitacao_insumo_item = 1045146
ORDER BY t.seq_insumo_unitario, t.dta_hor_cadastro DESC
FOR UPDATE;

--1046080
-----------------------------------------------------
 
 --IR duplicado
 --162555
 
select * from ESTOQUE.SOLICITACAO_INSUMO_ITEM t
where t.seq_solicitacao_insumo = 59257
--AND t.seq_solicitacao_insumo_item = 1029735
AND t.seq_insumo_unitario = 162555
ORDER BY t.seq_insumo_unitario, t.dta_hor_cadastro DESC;

select COUNT(*) QTD, T.SEQ_INSUMO_UNITARIO 
     from ESTOQUE.SOLICITACAO_INSUMO_ITEM t
WHERE 1 = 1
AND t.seq_solicitacao_insumo = 59257
AND t.idf_operacao = 6
AND t.seq_insumo_unitario = 162559--162555
GROUP BY t.seq_insumo_unitario;
--AND t.seq_solicitacao_insumo_item = 1029735
--ORDER BY t.seq_insumo_unitario, t.dta_hor_cadastro DESC;

--18371/2022
--

SELECT *
 FROM requisicao_material rm
 WHERE rm.num_requisicao = 840112
 AND rm.ano_requisicao_material = 2022;
 
 select * from ESTOQUE.ITEM_REQUISICAO_MATERIAL t
where t.num_requisicao = 840112
and   t.ano_requisicao_material = 2022;
----------------------------------------
DECLARE
   QTD_ITEM NUMBER;
   V_IR NUMBER; 
   ITENS_DUPLICADOS_EXEC EXCEPTION; 
BEGIN
  SELECT QTD,  SEQ_INSUMO_UNITARIO INTO QTD_ITEM, V_IR
  FROM (SELECT COUNT(*) QTD, T.SEQ_INSUMO_UNITARIO 
     FROM ESTOQUE.SOLICITACAO_INSUMO_ITEM T
      WHERE 1 = 1
      AND T.SEQ_SOLICITACAO_INSUMO = 59257
      AND T.IDF_OPERACAO = 6
    AND T.SEQ_INSUMO_UNITARIO = 162555 --162559
   GROUP BY T.SEQ_INSUMO_UNITARIO);
   
   IF QTD_ITEM IS NOT NULL OR QTD_ITEM > 0 THEN    
       RAISE ITENS_DUPLICADOS_EXEC;       
   END IF;
   
   EXCEPTION
      WHEN ITENS_DUPLICADOS_EXEC THEN         
        RAISE_APPLICATION_ERROR(-20001, 'Item IR'||V_IR||' já utilizado, risco de duplicar faturamento!' );
      WHEN OTHERS THEN NULL;
END; 
