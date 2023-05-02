SELECT ROWID,ue.*
 FROM unidade_executante ue 
 WHERE 1 = 1
 AND ue.cod_unidade_executante = 225
 OR ue.cod_unidade_executante_pai = 225;
 
 -------------------------------------
 SELECT *
  FROM centro_custo cc
  WHERE cc.cod_cencusto = 'CAAA00140';
  --"alima" e, "mdolmen"
  SELECT *
   FROM usuario u
   WHERE 1 = 1
   --AND U.NOM_USUARIO LIKE '%MONICA DOLMEN%'
   AND u.nom_usuario_banco = 'ALIMA';
 
 --ADRIANOLIMA: ADRIANO EUSTAQUIO URBANO DE LIMA
 --
