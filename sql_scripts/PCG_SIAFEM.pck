create or replace package GENERICO.PCG_SIAFEM is

  -- Author  : DAANSELMO
  -- Created : 25/01/2023 09:36:04
  -- Purpose : 
  --#=======================================
  /*Escopo esta incompleto por enquanto mas este � o template b�sico para gerar todas as interfacess*/  
  
  FUNCTION fnc_gera_saida RETURN XMLTYPE;

end PCG_SIAFEM;
/
create or replace package body GENERICO.PCG_SIAFEM IS


  FUNCTION fnc_gera_saida RETURN XMLTYPE
  IS
      TYPE ref_xml IS REF CURSOR;
      c_xml   ref_xml;
      r_xml   XMLTYPE;
  BEGIN
      OPEN c_xml FOR
       SELECT XMLROOT(
                      XMLELEMENT("SiafemDocNlPatrimonial"
                                  ,XMLELEMENT("documento"
                                             ,XMLForest( 'TipoMovimento' AS "TipoMovimento"
                                                        ,'Data' AS "Data"
                                                        ,'UgeOrigem' AS "UgeOrigem"
                                                        ,'Gestao' AS "Gestao"                                            
                                                        ,'Tipo_Entrada_Saida_Reclassificacao_Depreciacao' AS "Tipo_Entrada_Saida_Reclassificacao_Depreciacao"
                                                        ,'CpfCnpjUgeFavorecida' AS "CpfCnpjUgeFavorecida"
                                                        ,'Item' AS "Item"
                                                        ,'TipoEstoque' AS "TipoEstoque"
                                                        ,'Estoque' AS "Estoque"
                                                        ,'EstoqueDestino' AS "EstoqueDestino"
                                                        ,'EstoqueOrigem' AS "EstoqueOrigem"
                                                        ,'TipoMovimentacao' AS "TipoMovimentacao"
                                                        ,'ValorTotal' AS "ValorTotal"
                                                        ,'ControleEspecifico' AS "ControleEspecifico"
                                                        ,'ControleEspecificoEntrada' AS "ControleEspecificoEntrada"
                                                        ,'ControleEspecificoSaida' AS "ControleEspecificoSaida"
                                                        ,'FonteRecurso' AS "FonteRecurso"
                                                        ,'NLEstorno' AS "NLEstorno"
                                                        ,'Empenho' AS "Empenho"
                                                        ,'Observacao' AS "Observacao"                                            
                                             )
                                  )
                                 ,XMLELEMENT("NotaFiscal"
                                             ,XMLELEMENT("Repeticao"
                                                         ,XMLForest('NF1' AS "NF"
                                                         )
                                              )
                                  )
                       )
                      ,VERSION '1.0'
           ) AS SIAFEN
       FROM dual;
       
      FETCH c_xml INTO r_xml;
      
      IF c_xml%ISOPEN THEN
        dbms_output.put_line(r_xml.getClobVal());
      END IF;
            
      --CLOSE c_xml;
      RETURN  r_xml;
      
  END fnc_gera_saida;
end PCG_SIAFEM;
/
