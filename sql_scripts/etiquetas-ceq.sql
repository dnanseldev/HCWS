  
  SELECT *
   FROM numero_patrimonio np
   WHERE 1 = 1
    --AND np.num_patrimonio = 123716
   --AND np.cod_tipo_patrimonio = 34;
   AND np.num_bem = 216558;
   
   
   SELECT *
    FROM bem_patrimonial bp
    WHERE bp.num_patrimonio = 100479
    AND bp.cod_tipo_patrimonio = 56;
    
    
    SELECT *
     FROM 
