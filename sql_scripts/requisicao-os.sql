  SELECT A.NUM_REQUISICAO, A.ANO_REQUISICAO_MATERIAL, A.COD_CENCUSTO_EXECUTANTE, 
        A.NUM_REQUISICAO||'/'||A.ANO_REQUISICAO_MATERIAL REQUISICAO, 
        A.NUM_REQUISICAO, A.ANO_REQUISICAO_MATERIAL, 
        TO_CHAR(B.DTA_REQUISICAO,'DD/MM/YYYY HH24:MI:SS') DTA_REQUISICAO,
        B.COD_CENCUSTO_ATENDENTE, 
        DECODE(B.IDF_STATUS_REQUISICAO,0,'ABERTA',1,'IMPRESSA',2,'ATENDIDA',3,'CANCELADA') STATUS_REQUISICAO, 
        TO_CHAR(C.DTA_HOR_TRIAGEM,'DD/MM/YYYY HH24:MI:SS') DTA_TRIAGEM, C.NUM_ORDEM, 
        D.COD_SITUACAO_OS,  D.NUM_ORDEM_SERVICO||'/'||D.ANO_ORDEM_SERVICO NUM_OS, 
        D.NUM_ORDEM_SERVICO, D.ANO_ORDEM_SERVICO, 
        E.NOM_USUARIO||' '||E.SBN_USUARIO USAURIO, UE.NOM_UNIDADE_EXECUTANTE 
 FROM COMPLEMENTO_REQUISICAO A,  REQUISICAO_MATERIAL B, TRIAGEM_ORDEM_SERVICO C, 
      ORDEM_SERVICO D, USUARIO E ,
      (SELECT COD_UNIDADE_EXECUTANTE, NOM_UNIDADE_EXECUTANTE 
       FROM UNIDADE_EXECUTANTE 
       START WITH COD_UNIDADE_EXECUTANTE = 2
       CONNECT BY PRIOR  COD_UNIDADE_EXECUTANTE=COD_UNIDADE_EXECUTANTE_PAI) UE 
       
 WHERE 1 = 1
 -- AND B.COD_CENCUSTO_ATENDENTE = :COD_CENCUSTO_ATENDENTE 
  AND  C.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE 
  AND  C.NUM_TRIAGEM_OS = A.NUM_DOCUMENTO 
  AND  A.NUM_REQUISICAO = B.NUM_REQUISICAO 
  AND  A.ANO_REQUISICAO_MATERIAL = B.ANO_REQUISICAO_MATERIAL 
  AND  A.IDF_TIPO_DOCUMENTO = 17 
  AND  C.NUM_ORDEM = D.NUM_ORDEM 
  AND  B.IDF_SOLICITANTE = E.NUM_USER_BANCO 
  AND D.dta_criacao_os > (SYSDATE - 180 );
