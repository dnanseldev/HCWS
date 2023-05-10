CREATE OR REPLACE PROCEDURE DOCUMENTO."PROC_GERA_NUM_DOCUMENTO"
               ( V_COD_ESPECIE            IN    INSTITUICAO_ESPECIE_DOCUMENTO.COD_ESPECIE%TYPE,
                 V_COD_INSTITUICAO    IN     INSTITUICAO_ESPECIE_DOCUMENTO.COD_INSTITUICAO%TYPE,
                V_NUM_DOCUMENTO   OUT DOCUMENTO.NUM_DOCUMENTO%TYPE,
                V_ANO_DOCUMENTO    OUT DOCUMENTO.ANO_DOCUMENTO%TYPE)
/*  Data de Criação: 30/10/2000
     Autor: Silvio César Somera
     Finalidade: Dada a instituição e a espécie do documento a procedure retorno o número e no do documento a ser inserido
*/
IS
    v_numrows              Integer;
    v_nom_sequence   INSTITUICAO_ESPECIE_DOCUMENTO.NOM_SEQUENCE_DOCUMENTO%TYPE;
    v_nom_sequence2 INSTITUICAO_ESPECIE_DOCUMENTO.NOM_SEQUENCE_DOCUMENTO%TYPE;
    Cursor_sql               Integer;
    Cursor_sql2             Integer;
    v_numero         DOCUMENTO.NUM_DOCUMENTO%TYPE;
BEGIN
           SELECT COUNT(*) INTO V_NUMROWS
           FROM INSTITUICAO_ESPECIE_DOCUMENTO
           WHERE COD_ESPECIE=V_COD_ESPECIE
                 AND COD_INSTITUICAO=V_COD_INSTITUICAO;
           IF V_NUMROWS=1 THEN
               SELECT NOM_SEQUENCE_DOCUMENTO  INTO V_NOM_SEQUENCE
                FROM INSTITUICAO_ESPECIE_DOCUMENTO
                WHERE COD_ESPECIE=V_COD_ESPECIE
                      AND COD_INSTITUICAO=V_COD_INSTITUICAO;
                CURSOR_SQL := DBMS_SQL.OPEN_CURSOR;
                DBMS_SQL.PARSE(CURSOR_SQL,'SELECT '||V_NOM_SEQUENCE||'.NEXTVAL FROM DUAL', DBMS_SQL.NATIVE);
                DBMS_SQL.DEFINE_COLUMN(CURSOR_SQL,1,V_NUMERO);
                Cursor_sql2 := DBMS_SQL.EXECUTE(CURSOR_SQL);
                Cursor_sql2 := DBMS_SQL.FETCH_ROWS(CURSOR_SQL);
                DBMS_SQL.COLUMN_VALUE(CURSOR_SQL,1,V_NUMERO);
                DBMS_SQL.CLOSE_CURSOR(CURSOR_SQL);
                V_NUM_DOCUMENTO:=V_NUMERO;
                V_ANO_DOCUMENTO:=TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'));
           ELSE
              V_NUM_DOCUMENTO:=-1;
              V_ANO_DOCUMENTO:=-1;
           END IF;
END;

 
/
