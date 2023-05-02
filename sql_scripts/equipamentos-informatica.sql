/*
NOTEBOOK;
TABLET;
MICROCOMPUTADOR;
MONITOR;
TOTEM DE AUTOATENDIMENTO;
IMPRESSORA MULTIFUNCIONAL;
PROJETOR;
SCANNER;
TV;
IMPRESSORA 3D;
LOUSA INTERATIVA;
CELULAR CORPORATIVO;
PDA;
IMPRESSORA DE CÓDIGO DE BARRAS;
*/

SELECT 
        num_bem,
        x.cod_marca,    
        x.cod_tipo_bem,
        x.num_serie,
        x.num_patrimonio,
        x.cod_tipo_patrimonio,
        x.dsc_complementar,
        x.dsc_modelo,
        x.cpl_localizacao,    
        num_incorporacao,
        x.cod_instituicao,
        x.obs_patrimonio,
        inc.dta_hor_incorporacao,   
        cod_cencusto cc_atual,
        cc.nom_cencusto
 FROM 
(SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%NOTEBOOK%'
 UNION ALL 
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%MICROCOMPUTADOR%' 
 UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%TABLET%' 
  UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%MONITOR%'
 UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%TOTEM%AUTOATENDIMENTO%'
 UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%PROJETOR%'
 UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%SCANNER%'
 UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%TV%' 
UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%IMPRESSORA%3D%' 
UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%LOUSA%INTERATIVA%' 
UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%CELULAR%CORPORATIVO%' 
UNION ALL
SELECT *
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%PDA%'
UNION ALL
SELECT * 
 FROM bem_patrimonial bp
 WHERE UPPER(bp.dsc_complementar) LIKE '%IMPRESSORA DE CÓDIGO DE BARRAS%')X
 JOIN centro_custo_bem_patrimonial ccbp USING (num_bem) 
 JOIN centro_custo cc USING (cod_cencusto)
 LEFT JOIN incorporacao inc USING (num_incorporacao)  
 WHERE x.dta_desincorporacao IS NULL
  AND ccbp.dta_fim IS NULL;
 ------------------------------------
 SELECT *
 FROM material bp
 WHERE UPPER(bp.nom_material) LIKE '%LOUSA%'; 
