SELECT 1, COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '1%'
 
UNION

SELECT 2 , COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '2%'
 
 UNION
 
 SELECT 3 , COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '3%'
 
 UNION
 SELECT 4 , COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '4%'
 
 UNION
 
 SELECT 5, COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '5%'
 
 UNION
 
 SELECT 6, COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '6%'
 
 UNION
 
 SELECT 7, COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '7%'
 UNION
 
 SELECT 8, COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '8%'
 UNION
 
 SELECT 9, COUNT(*) inicio_patrimonios
 FROM bem_patrimonial bp
 WHERE bp.num_patrimonio LIKE '9%';
 
 --1 -> 58013
 --2 -> 29643
 --3 -> 13571
 --4 -> 14553
 --5 -> 16150
 --6 -> 15592
 --7 -> 14937
 --8 -> 12992
 --9 -> 11613
