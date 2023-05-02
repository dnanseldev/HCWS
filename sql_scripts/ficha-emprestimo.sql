-------------------------------------------------
--Ficha emprestimo
select * from ESTOQUE.COMPLEMENTO_REQUISICAO t
WHERE t.num_documento in (2083590, 2084157)
AND t.ano_requisicao_material = 2021;

SELECT -- ee.num_ordem,
        ee.dta_hor_emprestimo,
        LENGTH(ee.dsc_observacao) tam,
        ee.dsc_observacao,
        ee.seq_ordem_serv_tipo_emprestimo
 FROM emprestimo_equipamento ee
 WHERE ee.dta_cadastro > TRUNC(SYSDATE)
 AND ee.dta_cadastro < TRUNC(SYSDATE+1)
 --AND LENGTH(ee.dsc_observacao) > 250
 ORDER BY ee.dta_hor_emprestimo DESC;
 
 
 SELECT *
  FROM tipo_vacina tv
  WHERE tv.cod_tipo_vacina = 70;
 
 
