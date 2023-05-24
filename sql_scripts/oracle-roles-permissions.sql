/*Query para consultar roles para um usuário*/
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'DAANSELMO';

/*Privilégios concedidos a um usuário*/
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'DAANSELMO';

/*Privilégios concedidos a objetos conforme privilégio concedido a uma role de um usuário*/
SELECT * FROM DBA_TAB_PRIVS D
 WHERE 1 = 1
 AND D.TABLE_NAME = 'ORDEM_SERVICO'
AND D.GRANTEE IN (SELECT granted_role FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'DAANSELMO') order by 3;

/*Consulta para verificar se o usuário possui privilégios de sistema*/
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = '&NOMEDOUSUARIO';

/*Consulta para verificar as permissões concedidas a uma role*/
select * from ROLE_ROLE_PRIVS where ROLE = '&NOME_DA_ROLE';
select * from ROLE_TAB_PRIVS where ROLE = '&NOME_DA_ROLE';
select * from ROLE_SYS_PRIVS where ROLE = '&NOME_DA_ROLE';

/*Referências:*/
DBA_SYS_PRIVS
DBA_TAB_PRIVS
DBA_ROLE_PRIVS
