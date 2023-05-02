-- Carro de Emerg�ncia Ambulat�rio Cl. M�dica/ Cirurgia

SELECT *
 FROM repositorio_lista_controle rpl
 WHERE 1 = 1
 AND UPPER(rpl.dsc_identificacao) LIKE '%AMBULAT%'
 AND rpl.seq_tip_reposit_lst_control = 1
-- AND rpl.seq_repositorio = 24;
ORDER BY rpl.dsc_identificacao ASC;
 
select * from GENERICO.LACRE_REPOSITORIO t
where t.seq_repositorio = 24
ORDER BY 1 DESC;

---------------------------------------------------------

select * from MANUTENCAO.BEM_PATRIMONIAL t
WHERE 1 = 1
AND t.num_patrimonio = 10162;
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
AND lre.num_bem = 106069
ORDER BY dta DESC;

SELECT DISTINCT
       seq_repositorio
      ,lrc.dsc_identificacao
      ,seq_lacre_reposit_equip
      --,seq_lacre_repositorio
      ,LAST_day(lre.dta_cadastro) dta  
    FROM GENERICO.LACRE_REPOSIT_EQUIPAMENTO lre
    JOIN GENERICO.LACRE_REPOSITORIO lr USING(seq_lacre_repositorio)
    JOIN GENERICO.REPOSITORIO_LISTA_CONTROLE lrc USING(seq_repositorio)
    WHERE 1 = 1
AND lre.num_bem = 106069
AND seq_repositorio = 16
ORDER BY dta DESC;


select ROWID,t.* from GENERICO.LACRE_REPOSIT_EQUIPAMENTO t
WHERE 1 = 1
AND t.num_bem = 106069
AND t.seq_lacre_reposit_equip IN (142377)
ORDER BY t.dta_cadastro DESC;
--AND t.seq_lacre_reposit_equip = 140463;
--AND t.seq_lacre_repositorio = 44502;
---------------------------------------------------------
