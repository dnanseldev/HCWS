SELECT *
 FROM solicitacao_insumo sit 
 WHERE 1 = 1
 AND sit.cod_paciente = '1680606D'
 ORDER BY sit.dta_hor_cadastro DESC;
 -------------------------------------
 --9785
 select * from ESTOQUE.SOLICITACAO_INSUMO_ITEM t
where t.seq_solicitacao_insumo = 58506
--AND t.seq_insumo = 9785
--AND t.seq_solicitacao_insumo_item = 1012322
--FOR UPDATE;
--AND t.num_lote = 631376
ORDER BY t.seq_insumo_unitario
        ,t.idf_operacao
        ,t.dta_hor_cadastro DESC;
--------------------------------------
select * from GENERICO.INSUMO t
where t.cod_material = '26100460';
--26100460
----------------------------------
GENERICO.PROC_BUSCA_ITENS_SOLICITACA
