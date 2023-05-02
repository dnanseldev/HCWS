SELECT --bp.num_patrimonio
       --,tp.dsc_tipo_patrimonio
        bp.num_patrimonio||'-'||tp.dsc_tipo_patrimonio patrimonio
       ,bp.dsc_complementar
       ,inc.cod_material
  FROM bem_patrimonial bp
  JOIN incorporacao inc USING(num_incorporacao)
  JOIN tipo_patrimonio tp USING(cod_tipo_patrimonio)
  WHERE 1 = 1
  AND inc.dta_hor_incorporacao >= to_date('01/06/2022', 'DD/MM/YYYY');
  
  
  SELECT --bp.num_patrimonio
       --,tp.dsc_tipo_patrimonio
        --bp.num_patrimonio||'-'||tp.dsc_tipo_patrimonio patrimonio
       --,bp.dsc_complementar
       inc.*
  FROM bem_patrimonial bp
  JOIN incorporacao inc USING(num_incorporacao)
  JOIN tipo_patrimonio tp USING(cod_tipo_patrimonio)
  WHERE 1 = 1
  AND inc.dta_hor_incorporacao >= to_date('01/06/2022', 'DD/MM/YYYY');
  
  SELECT *
   FROM incorporacao inc
   WHERE inc.dta_hor_incorporacao >= to_date('01/06/2022', 'DD/MM/YYYY');
 -----------------------------------------------------------------------
 SELECT '' ||XMLROOT(  XMLELEMENT("Patrimonio", bp.num_patrimonio||'-'||tp.dsc_tipo_patrimonio) 
                      ,VERSION '1.0' 
             ) AS Teste
  FROM bem_patrimonial bp
  JOIN incorporacao inc USING(num_incorporacao)
  JOIN tipo_patrimonio tp USING(cod_tipo_patrimonio)
  WHERE 1 = 1
  AND inc.dta_hor_incorporacao >= to_date('01/06/2022', 'DD/MM/YYYY');
  -----------------------------------------------------------------------
   SELECT XMLAgg(
                      XMLELEMENT("SIAFEN"   
                                 ,XMLForest( num_patrimonio||'-'||dsc_tipo_patrimonio AS "Patrimonio"
                                           ,bp.dsc_complementar AS "descricao"
                                  )
                       ) 
              ) AS SIAFEN
          --XMLELEMENT("Patrimonio", num_patrimonio||'-'||dsc_tipo_patrimonio)
  FROM bem_patrimonial bp
  JOIN incorporacao inc USING(num_incorporacao)
  JOIN tipo_patrimonio tp USING(cod_tipo_patrimonio)
  WHERE 1 = 1
  AND inc.dta_hor_incorporacao >= to_date('01/06/2022', 'DD/MM/YYYY');
  /*
  <documento>
          <TipoMovimento>Depreciação</TipoMovimento> 
          <Data>11/11/2016</Data> 
          <UgeOrigem>200102</UgeOrigem> 
          <Gestao>00001</Gestao> 
          <Tipo_Entrada_Saida_Reclassificacao_Depreciacao>DEPRECIAÇÃO - BAIXA</Tipo_Entrada_Saida_Reclassificacao_Depreciacao> 
          <CpfCnpjUgeFavorecida></CpfCnpjUgeFavorecida> 
          <GestaoFavorecida></GestaoFavorecida> 
          <Item>4585259</Item> 
          <TipoEstoque>PERMANENTE</TipoEstoque> 
          <Estoque></Estoque> 
          <EstoqueDestino>DEPRECIAÇÃO ACUMULADA DE BENS DE INFORMATICA</EstoqueDestino> 
          <EstoqueOrigem>PATRIMÔNIO - BENS MOVEIS</EstoqueOrigem> 
          <TipoMovimentacao></TipoMovimentacao> 
          <ValorTotal>0,54</ValorTotal> 
          <ControleEspecifico></ControleEspecifico> 
          <ControleEspecificoEntrada></ControleEspecificoEntrada> 
          <ControleEspecificoSaida></ControleEspecificoSaida> 
          <FonteRecurso></FonteRecurso> 
          <NLEstorno>N</NLEstorno> 
          <Empenho></Empenho> 
          <Observacao>Teste Web Servcie</Observacao> 
        </documento>
  */
  
  SELECT     XMLROOT(
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
   
   
   
   -------------------------------
    SELECT     XMLROOT(
                      XMLELEMENT("documento"
                                 ,XMLForest( 'TipoMovimento' AS "TipoMovimento"
                                            ,'Data' AS "Data"
                                            ,'UgeOrigem' AS "UgeOrigem"
                                            ,'Gestao' AS "Gestao"
                                            --,"" AS ""                                                                                       
                                 )
                      )
                     ,VERSION '1.0'
         ) AS SIAFEN
   FROM dual;
  
  
  
  
