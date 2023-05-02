-- Carro de Emergência Ambulatório Cl. Médica/ Cirurgia

SELECT *
 FROM repositorio_lista_controle rpl
 WHERE 1 = 1
 --AND UPPER(rpl.dsc_identificacao) LIKE '%AMBULAT%'
 AND rpl.seq_tip_reposit_lst_control = 1
 AND rpl.seq_repositorio = 41;
--ORDER BY rpl.dsc_identificacao ASC;
 
select * from GENERICO.LACRE_REPOSITORIO t
where t.seq_repositorio = 15
ORDER BY 1 DESC;

---------------------------------------------------------
/*
Descrição: Solicitamos excluir o equipamento nº de patrimônio 288 FINEP - Cardioversor HeartStart XL, do Carro de Emergência OFTALMO/OTORRINO/CCP e do Carro de Emergência CLÍNICA CIVIL ENFERMARIA UPC. Esse carro (UPC) encontra-se emprestado para o projeto Butantã, alocado no Hemocentro e será desativado.nAtenciosamente.

Materiais e Equip.: 288/FINEP - CARDIOVERSOR HEARTSTART XL, MARCA PHILIPS MEDICAL - LOCAL FISICO: Sem Localização (LOC.:
Nº OS: 73112/2022*/
select * from MANUTENCAO.BEM_PATRIMONIAL t
WHERE 1 = 1
AND t.num_patrimonio = 288
AND t.cod_tipo_patrimonio = 48;
--AND t.num_bem in (227757, 103657, 87117, 52633);
--HCRP**25194;

-----------------------------------------
SELECT DISTINCT
       seq_repositorio
      ,lrc.dsc_identificacao
     -- ,seq_lacre_reposit_equip
      --,seq_lacre_repositorio
      ,LAST_day(lre.dta_cadastro) dta  
    FROM GENERICO.LACRE_REPOSIT_EQUIPAMENTO lre
    JOIN GENERICO.LACRE_REPOSITORIO lr USING(seq_lacre_repositorio)
    JOIN GENERICO.REPOSITORIO_LISTA_CONTROLE lrc USING(seq_repositorio)
    WHERE 1 = 1
AND lre.num_bem = 189524
ORDER BY dta DESC;

SELECT DISTINCT
       seq_repositorio
      ,lr.cod_situacao_atual
      ,lrc.dsc_identificacao
      ,seq_lacre_reposit_equip
      --,seq_lacre_repositorio
      ,LAST_day(lre.dta_cadastro) dta  
    FROM GENERICO.LACRE_REPOSIT_EQUIPAMENTO lre
    JOIN GENERICO.LACRE_REPOSITORIO lr USING(seq_lacre_repositorio)
    JOIN GENERICO.REPOSITORIO_LISTA_CONTROLE lrc USING(seq_repositorio)
    WHERE 1 = 1
AND lre.num_bem = 189524
AND seq_repositorio = 69
ORDER BY seq_lacre_reposit_equip DESC;

---------------------------------------------------
SELECT *
  FROM (SELECT DISTINCT
       seq_repositorio
   --   ,lrc.dsc_identificacao
      ,seq_lacre_reposit_equip
      --,seq_lacre_repositorio
      ,lre.idf_ativo
      ,LAST_day(lre.dta_cadastro) dta 
     
    FROM GENERICO.LACRE_REPOSIT_EQUIPAMENTO lre
    JOIN GENERICO.LACRE_REPOSITORIO lr USING(seq_lacre_repositorio)
    JOIN GENERICO.REPOSITORIO_LISTA_CONTROLE lrc USING(seq_repositorio)
    WHERE 1 = 1
AND lre.num_bem = 189524
AND seq_repositorio = 69
ORDER BY seq_lacre_reposit_equip DESC)
WHERE ROWNUM <= 5;
--------------------------------------------------
select ROWID,t.* from GENERICO.LACRE_REPOSIT_EQUIPAMENTO t
WHERE 1 = 1
AND t.num_bem = 189524
AND seq_lacre_reposit_equip in (112987, 110951, 108541, 105895, 103219);



---------------------------------------------------
select ROWID,t.* from GENERICO.LACRE_REPOSIT_EQUIPAMENTO t
WHERE 1 = 1
AND t.num_bem = 166415
AND t.seq_lacre_reposit_equip IN (
   SELECT x.seq_lacre_reposit_equip 
  FROM (SELECT DISTINCT
       seq_repositorio
   --   ,lrc.dsc_identificacao
      ,seq_lacre_reposit_equip
      --,seq_lacre_repositorio
   --   ,LAST_day(lre.dta_cadastro) dta  
    FROM GENERICO.LACRE_REPOSIT_EQUIPAMENTO lre
    JOIN GENERICO.LACRE_REPOSITORIO lr USING(seq_lacre_repositorio)
    JOIN GENERICO.REPOSITORIO_LISTA_CONTROLE lrc USING(seq_repositorio)
    WHERE 1 = 1
AND lre.num_bem = 166415
AND seq_repositorio = 28) x
)
ORDER BY t.dta_cadastro DESC;
--AND t.seq_lacre_reposit_equip = 140463;
--AND t.seq_lacre_repositorio = 44502;
---------------------------------------------------------
select  ROWID
       ,t.* from GENERICO.ITENS_LISTA_CONTROLE t
where t.seq_lista_controle = 20
AND t.seq_itens_lista_controle = 11047;

