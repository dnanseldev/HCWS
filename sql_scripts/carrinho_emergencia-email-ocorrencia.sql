 /*=======================================*/
    SELECT DISTINCT U.NUM_USER_BANCO, 
                U.NOM_USUARIO, 
                U.SBN_USUARIO,
                CC_USU.Cod_Cencusto, 
                USU_CPL.DSC_EMAIL EMAIL 
  FROM USUARIO_ROLE             UR, 
       ROLE                     R, 
       USUARIO                  U, 
       CENTRO_CUSTO_USUARIO     CC_USU, 
       REPOSITORIO_CENTRO_CUSTO REPOSIT_CC, 
       COMPLEMENTO_USUARIO      USU_CPL 
 WHERE UR.COD_ROLE = R.COD_ROLE 
   AND UR.NUM_USER_BANCO = U.NUM_USER_BANCO
   AND CC_USU.COD_CENCUSTO = REPOSIT_CC.COD_CENCUSTO 
   AND CC_USU.NUM_USER_BANCO = U.NUM_USER_BANCO 
    AND USU_CPL.NUM_USER_BANCO = U.NUM_USER_BANCO
   --AND REPOSIT_CC.SEQ_REPOSITORIO in (364)--ID do Repositório
   AND CC_USU.NUM_USER_BANCO = 61582
   AND R.COD_ROLE = 1106; --USUARIO GESTOR
 
 /*=======================================*/
 select 
         u.num_user_banco, 
         u.nom_usuario, 
         u.sbn_usuario,
         cod_cencusto,
         seq_repositorio,
         rlc.dsc_identificacao,
         cu.dsc_email
     from usuario_role ur
     join usuario u on u.num_user_banco = ur.num_user_banco
       and u.num_user_banco = 61582 --USUARIO GESTOR
       and ur.cod_role = 1106 --ROLE USUARIO GESTOR
     join complemento_usuario cu on cu.num_user_banco = u.num_user_banco
     join centro_custo_usuario ccu on ccu.num_user_banco = u.num_user_banco
     join repositorio_centro_custo rcu using(cod_cencusto)
     join repositorio_lista_controle rlc using(seq_repositorio);
 
 
 
     SELECT DISTINCT U.NUM_USER_BANCO, 
                U.NOM_USUARIO, 
                U.SBN_USUARIO,
                CC_USU.Cod_Cencusto, 
                USU_CPL.DSC_EMAIL EMAIL 
  FROM USUARIO_ROLE             UR, 
       ROLE                     R, 
       USUARIO                  U, 
       CENTRO_CUSTO_USUARIO     CC_USU, 
       REPOSITORIO_CENTRO_CUSTO REPOSIT_CC, 
       COMPLEMENTO_USUARIO      USU_CPL 
 WHERE UR.COD_ROLE = R.COD_ROLE 
   AND UR.NUM_USER_BANCO = U.NUM_USER_BANCO
   AND CC_USU.COD_CENCUSTO = REPOSIT_CC.COD_CENCUSTO 
   AND CC_USU.NUM_USER_BANCO = U.NUM_USER_BANCO 
    AND USU_CPL.NUM_USER_BANCO = U.NUM_USER_BANCO
   --AND REPOSIT_CC.SEQ_REPOSITORIO in (364)--ID do Repositório
   AND CC_USU.NUM_USER_BANCO = 61582
   AND R.COD_ROLE = 1106; --USUARIO GESTOR
 /*=======================================*/
 --61582 LIGIA APARECIDA DOS SANTOS OUSHIRO
 SELECT *
  FROM usuario u
  WHERE u.nom_usuario LIKE '%LIGIA APARECIDA%';
  
   SELECT *
  FROM CENTRO_CUSTO_USUARIO  CC_USU
  WHERE CC_USU.NUM_USER_BANCO = 61582;
  
   
 SELECT *
  FROM REPOSITORIO_CENTRO_CUSTO rcc
  WHERE 1 = 1
  AND rcc.num_user_cadastro = 61582;
  
   select t.cod_instituto,t.* from PRESCRICAO.CENTRO_CUSTO t
where t.cod_cencusto 
 in ('CACJ01011', 'MATER0003', 'MATER0001', 'MATER0002', 'MATER0004', 'MATER0034', 'MATER0035', 'MATER0033', 'MATER0086', 'MATER0025', 'MATER0018');
-- in ('MATER0034', 'MATER0003', 'MATER0002', 'MATER0004');
  
  select * from GENERICO.REPOSITORIO_CENTRO_CUSTO t
where t.seq_repositorio = 364;
  



SELECT *
 FROM repositorio_lista_controle rlc
 WHERE rlc.dsc_identificacao LIKE '%CAIXA PSICO%'
 AND RLC.SEQ_REPOSITORIO = 364;
