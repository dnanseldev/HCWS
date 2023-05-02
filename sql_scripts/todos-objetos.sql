SELECT *
 FROM ALL_TRIGGERS  ue
 WHERE UE.TABLE_OWNER LIKE '%DAANSELMO%';
 
 
 SELECT *
  FROM DBA_TAB_PRIVS D
  WHERE D.GRANTEE = 'DAANSELMO';
  
  SELECT owner, table_name, select_priv, insert_priv, delete_priv, update_priv, references_priv, alter_priv, index_priv 
  FROM table_privileges
 WHERE grantee = 'DAANSELMO'
 ORDER BY owner, table_name;
 
 select dbms_metadata.get_granted_ddl( 'SYSTEM_GRANT', 'ELENI' ) from dual;
select dbms_metadata.get_granted_ddl( 'OBJECT_GRANT', 'ELENI' ) from dual;
select dbms_metadata.get_granted_ddl( 'ROLE_GRANT', 'ELENI' ) from dual;
