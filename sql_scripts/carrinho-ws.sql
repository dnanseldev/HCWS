--==================================
--REPOSITORIO
SELECT *
 FROM repositorio_lista_controle rpl
 WHERE rpl.dsc_identificacao LIKE '%BLOQUEIO%'
 AND RPL.SEQ_REPOSITORIO = 492;
 
 select * from GENERICO.ITENS_LISTA_CONTROLE t
where t.seq_lista_controle = 260;
 

 select * from GENERICO.LISTA_CONTROLE t
where t.seq_lista_controle = 260;

WITH cur_lacre AS (
   select MAX(t.seq_lacre_repositorio) lacre from GENERICO.LACRE_REPOSITORIO t
  where t.seq_repositorio = 492
)



select * from GENERICO.LACRE_REPOSITORIO t
WHERE t.seq_lacre_repositorio IN (
   SELECT * FROM cur_lacre
);

SELECT *
FROM MOVIMENTACAO_REPOSITORIO MR
WHERE 1 = 1
AND mr.seq_repositorio = 492
--AND mr.seq_lacre_repositorio = 
AND mr.seq_lacre_repositorio = ( select MAX(t.seq_lacre_repositorio) lacre from GENERICO.LACRE_REPOSITORIO t
  where t.seq_repositorio = 492);
--============================================
--ITENS DO LACRE
select * from GENERICO.LACRE_REPOSITORIO_ITENS t
where t.seq_lacre_repositorio = ( select MAX(t.seq_lacre_repositorio) lacre from GENERICO.LACRE_REPOSITORIO t
  where t.seq_repositorio = 492);
  
  select t.seq_lacre_repositorio_itens,
         t.seq_lacre_repositorio,
         t.qtd_disponivel,
         (SELECT t.QTD_DISPONIVEL - NVL(SUM(X.QTD_UTILIZADA),0) 
            FROM LACRE_REPOSIT_UTILIZACAO X 
            WHERE X.SEQ_LACRE_REPOSITORIO_ITENS =  t.SEQ_LACRE_REPOSITORIO_ITENS) QTD_RESTANTE,
         t.qtd_conferido,
         t.cod_material,
         t.num_lote,
         t.seq_itens_lista_controle,
         t.num_lote_fabricante,
         t.dta_validade_lote,
         t.dta_cadastro,
         t.dta_ultima_alteracao,
         t.num_user_cadastro,
         t.num_user_ultima_alteracao        
         
   from GENERICO.LACRE_REPOSITORIO_ITENS t
WHERE 1 = 1
AND t.seq_lacre_repositorio = 58382 
AND t.seq_lacre_repositorio = ( select MAX(t.seq_lacre_repositorio) lacre from GENERICO.LACRE_REPOSITORIO t
  where t.seq_repositorio = 492);
  

--============================================


--59511


select t.seq_lacre_repositorio
      ,h.nom_situacao
    from GENERICO.LACRE_REPOSITORIO t
 JOIN TIPO_SITUACAO_HC h ON h.cod_situacao = t.cod_situacao_atual
  where t.seq_repositorio = 492
  ORDER BY 1 DESC;



--===================================  
  -- Lacre: 59872, LRI: 3780527
  --CodMat: 61200918
  SELECT *
 FROM REQUISICAO_MATERIAL rm
 WHERE rm.num_requisicao = 175170
 AND rm.ano_requisicao_material = 2023;
 
 select * from ESTOQUE.ITEM_REQUISICAO_MATERIAL t
 WHERE t.cod_material = '61200918';
 
 select * from ESTOQUE.COMPLEMENTO_REQUISICAO t
 WHERE t.num_documento = 58382
 AND t.idf_tipo_documento = 23;
 
--=====================================
--CONSUMO 

/*
Repositório:
  KIT BLOQUEIO RAQUI/PERI 04
  
Saidas:
 1061096/2023 - 01/07/2023 04:11
 1061097/2023 - 01/07/2023 04:13
 
Reposições:
  1061103/2023 01/07/2023 - 04:16 - Reposição
  1250257/2023 01/08/2023 - 17:17 - Reposição
*/

SELECT z.seq_lacre_reposit_util,
       z.seq_atendimento,
       seq_lacre_repositorio_itens,
       lri.cod_material,
       z.qtd_utilizada,
       z.dsc_justificativa,
       z.dta_cadastro,
       z.num_user_cadastro
 FROM LACRE_REPOSIT_UTILIZACAO Z
 JOIN GENERICO.LACRE_REPOSITORIO_ITENS  lri USING (seq_lacre_repositorio_itens)
 WHERE 1 = 1
 AND lri.seq_lacre_repositorio = 58382;

SELECT num_requisicao,
       ano_requisicao_material,
       cr.num_documento, 
       --cr.idf_tipo_documento,
       CASE  rm.idf_tipo_requisicao
        WHEN 0 THEN 'Entrega'
        WHEN 1 THEN 'Devolucao'
        WHEN 2 THEN 'Transferencia'
       END idf_tipo_requisicao,
       tdr.dsc_tipo_docto_requisicao, 
       rm.idf_solicitante,
       rm.cod_cencusto_solicitante,
       rm.dta_requisicao,
       rm.idf_atendente,
       rm.dta_atendimento,
       rm.cod_cencusto_atendente,
       rm.idf_status_requisicao,
       rm.idf_prioridade,
       rm.idf_sub_tipo_requi,
       rm.cod_paciente,
       rm.dta_hor_prev_entrega
 FROM REQUISICAO_MATERIAL rm
 JOIN ESTOQUE.COMPLEMENTO_REQUISICAO cr USING(num_requisicao, ano_requisicao_material)
 JOIN ESTOQUE.TIPO_DOCUMENTO_REQUISICAO tdr ON tdr.cod_tipo_docto_requisicao = cr.idf_tipo_documento
 WHERE num_requisicao = 1061096
 AND   ano_requisicao_material = 2023;
 
 
 select t.ano_requisicao_material,
        t.num_requisicao,
        t.cod_material,
        t.qtd_requisi_devolvida,
        t.cod_ocorrencia,
        t.qtd_forne_recebida,
        t.vlr_ponderado,
        t.dta_transfer_prodesp,
        t.dsc_justificativa,
        t.idf_tipo_material,
        t.dta_mov_contabil,
        t.vlr_ultima_compra,
        t.qtd_empenhada
      from ESTOQUE.ITEM_REQUISICAO_MATERIAL t
where t.num_requisicao = --1263277
and   t.ano_requisicao_material = 2023;
 --================================
 
 SELECT *
  FROM repositorio_centro_custo rcc
  WHERE rcc.cod_cencusto = 'MATER0008';
 
 SELECT *
 FROM ITEM_REQUISICAO_LOTE irl;
