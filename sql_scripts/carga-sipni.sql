SELECT  cod_paciente
       ,p.nom_paciente||' '||p.sbn_paciente nom_paciente
       ,p.idf_sexo
       ,p.dta_nascimento
       ,p.nom_mae
       ,p.dsc_endereco
       ,p.idf_estado
       ,p.cep_paciente
       ,p.dsc_naturalidade
       ,pais.dsc_pais pais_nascimento
       ,p.num_cns cartao_nacional_sus       
       ,tv.dsc_tipo_vacina
       ,vra.dta_hor_aplicacao
       ,d.dsc_dose
       ,l.num_lote_fabricante
       ,ev.dsc_estrategia estrategia
       ,i.dsc_indicacao
       ,fab.nom_fabricante laboratorio
       ,'N�O INFORMADO' "ESPECIALIDADE"
 FROM vacina_recepcao vr
 JOIN vacina_recepcao_aplicacao vra USING(seq_vacina_recepcao)
 LEFT JOIN utilizacao_material um USING(seq_utilizacao_material)
 LEFT JOIN indicacao_vacina_material ivm USING(seq_ind_vacina_material, cod_tipo_vacina) 
 LEFT JOIN indicacao_vacina i USING(seq_indicacao_vacina)
 LEFT JOIN vacina_configuracao vc USING(seq_ind_vacina_material, cod_tipo_vacina) 
 LEFT JOIN estrategia_vacinacao ev USING(seq_estrategia_vacina)
 LEFT JOIN lote l USING(num_lote)
 JOIN tipo_vacina tv USING(cod_tipo_vacina)
 JOIN dose d USING(num_dose)
 JOIN paciente p USING(cod_paciente)
 LEFT JOIN item_nota_fiscal inf USING(seq_nota_fiscal, cod_material)
 LEFT JOIN marca mar USING(cod_marca)
 LEFT JOIN fabricante fab USING(cod_fabricante)
 JOIN PAIS USING (sgl_pais)
 
 WHERE 1 = 1
 --AND REGEXP_LIKE (tv.dsc_tipo_vacina, '[\w]+\s[\w]+');
 AND vra.dta_hor_aplicacao >= to_date('01/01/2021', 'DD/MM/YYYY');
-- AND cod_paciente = '1629066A';
 --AND REGEXP_LIKE(dsc_tipo_vacina, '[a-zA-Z]+\s[a-zA-Z]*|\d*');
 -----------------------------------------------------------------
 
 SELECT *
  FROM utilizacao_material um;
 
 SELECT *
  FROM paciente p;
  
  SELECT *
   FROM Vacina_Recepcao vr
   WHERE vr.cod_paciente = '1629066A';
  
  SELECT *
   FROM vacina_recepcao_aplicacao v
   WHERE v.dta_hor_aplicacao > to_Date('01/05/2021', 'DD/MM/YYYY');
  
  
  SELECT REGEXP_SUBSTR('Daniel Stonebuilt 36', '(\w+)}') rest
  FROM dual;
  
  SELECT *
   FROM lote l
   --LEFT JOIN item_nota_fiscal inf USING(seq_nota_fiscal)
  -- LEFT JOIN marca mar USING(cod_marca)
  -- LEFT JOIN fabricante fab USING(cod_fabricante)
   WHERE 
   num_lote_fabricante in ('T027742', 'AP2231', 'CF0990', '210227', '2330L003B', '190219', '210152', 'TB0028B', '210160', '205VVA030Z');
   
   SELECT *
    FROM all_tables a
    WHERE a.TABLE_NAME LIKE 'CENTRO_CUS%%INTEGRA%';
    
    SELECT *
     FROM GENERICO.CENTRO_CUSTO_INTEGRACAO CC;
     
     
     SELECT *
      FROM ordem_servico os;

SELECT *
 FROM centro_custo_usuario_permissao c
 WHERE c.cod_cencusto = 'CCEA0001X'
 AND c.cod_unidade_executante = 1
 AND c.idf_ativo = 0;
