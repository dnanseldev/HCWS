/*
Author: Daniel Anselmo
purpose: Impedir duplica��o de mesmo item no faturamento da consigna��o
*/
CREATE OR REPLACE TRIGGER TG_BI_SOL_ITEM_PREVENT_DUPLICACAO
  BEFORE INSERT OR UPDATE
  ON ESTOQUE.SOLICITACAO_INSUMO_ITEM 
  FOR EACH ROW
DECLARE
   QTD_ITEM NUMBER;
   V_IR NUMBER; 
   ITENS_DUPLICADOS_EXEC EXCEPTION;  
BEGIN
  SELECT QTD,  SEQ_INSUMO_UNITARIO INTO QTD_ITEM, V_IR
  FROM (SELECT COUNT(*) QTD, T.SEQ_INSUMO_UNITARIO 
     FROM ESTOQUE.SOLICITACAO_INSUMO_ITEM T
      WHERE T.SEQ_SOLICITACAO_INSUMO = :OLD.SEQ_SOLICITACAO_INSUMO
      AND T.IDF_OPERACAO = 6
    AND T.SEQ_INSUMO_UNITARIO = :NEW.SEQ_INSUMO_UNITARIO
   GROUP BY T.SEQ_INSUMO_UNITARIO);
   
   IF QTD_ITEM IS NOT NULL OR QTD_ITEM > 0 THEN    
       RAISE ITENS_DUPLICADOS_EXEC;       
   END IF;
   
   EXCEPTION
     WHEN ITENS_DUPLICADOS_EXEC THEN         
       RAISE_APPLICATION_ERROR(-20001, 'Item IR'||V_IR||' j� utilizado, risco de duplicar faturamento!' );
     WHEN OTHERS THEN NULL;  
  
END TG_BI_SOL_ITEM_PREVENT_DUPLICACAO;
/
