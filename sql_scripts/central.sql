    SELECT *
       FROM bem_patrimonial bp
       WHERE bp.num_patrimonio IN (101441)
       AND bp.cod_tipo_patrimonio = 56
       FOR UPDATE;
       
       101441-HCRP**
      
       --218559
       
        select * from GENERICO.TIPO_IMAGEM_EQUIPAMENTO t;
       
    
     
     select * from GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI t
     WHERE t.seq_tipo_imagem_equipamento = 11;
     --FOR UPDATE;
    where t.seq_tipo_imagem_equipamento = 3
    AND t.num_user_cadastro = 66827;
    
    Select * from GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI t
    WHERE T.num_bem 
    in (220681, 220682, 220683, 220685, 220686, 220687, 220688, 220689, 220690);
   
    
   SELECT *
    FROM All_Tables a
    WHERE a.TABLE_NAME LIKE '%ORDEM%%';
    
 SELECT * FROM GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO;
 
 
 SELECT bp.num_patrimonio||'-'||tp.dsc_tipo_patrimonio 
 FROM bem_patrimonial bp
 JOIN tipo_patrimonio tp ON tp.cod_tipo_patrimonio = bp.cod_tipo_patrimonio
 WHERE bp.num_patrimonio IN
 (27468,27469,27470,27471,27472,27473,27474,27475,27476)
  AND bp.cod_tipo_patrimonio = 57;
  
   SELECT * 
 FROM bem_patrimonial bp
 --JOIN tipo_patrimonio tp ON tp.cod_tipo_patrimonio = bp.cod_tipo_patrimonio
 WHERE bp.num_patrimonio IN
 (27468,27469,27470,27471,27472,27473,27474,27475,27476)
  AND bp.cod_tipo_patrimonio = 57
  FOR UPDATE;
  
  SELECT *
   FROM centro_custo_bem_patrimonial c
   WHERE c.num_bem IN (220681, 220682, 220683, 220685, 220686, 220687, 220688, 220689, 220690)
   AND c.dta_fim IS NULL;
   
    SELECT * 
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio = 101441
 FOR UPDATE;
