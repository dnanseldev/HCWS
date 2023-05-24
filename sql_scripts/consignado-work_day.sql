/**=============================CONSIGNADO==================================*/

SELECT *
 FROM solicitacao_insumo s
 WHERE 1 = 1
 AND s.cod_paciente = '0814510E'
 AND EXTRACT(YEAR FROM s.dta_hor_cadastro) = 2023;
 
select t.*, ROWID from ESTOQUE.SOLICITACAO_INSUMO_ITEM t
where 1 = 1
AND t.seq_solicitacao_insumo = 70976
AND t.seq_insumo_unitario IN (190896);
----------------------------------------
190896 / 179099/ 182382/ 182276/ 180400

