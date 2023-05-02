   SELECT * FROM V_FUNCIONARIO_RUBI r
  WHERE r.NUMCAD = 6373
  AND R.NUMLOC = 5318; 
  --1340268A DANIEL ANSELMO
 --***************************************
 --EMPRESA
  SELECT 
        V.NOMEMP, 
        V.APEEMP, 
        V.NUMCGC, 
        V.NUMEMP, 
        V.SIGEMP
   FROM 
        V_EMPRESA_RUBI V ;
 --***************************************
 SELECT 
  F.NUMEMP, -- EMPRESA 
  F.NUMCAD, -- MATRICULA  
  E.APEEMP,
  F.NOMFUN,
  F.NUMCPF,
  F.DATADM,
  F.DATAFA, -- DATA DEMISS�O SE F.SITAFA IN (SELECT S.CODSIT FROM R010SIT S WHERE S.TIPSIT = 7)
  C.TITRED
FROM SENIOR.R034FUN F
    LEFT JOIN R024CAR C ON C.ESTCAR = F.ESTCAR AND C.CODCAR = F.CODCAR
    LEFT JOIN R030EMP E ON E.NUMEMP = F.NUMEMP
WHERE
  F.TIPCOL = 1 -- sempre 1
  -- filtro de demitido/admitido  
  AND F.SITAFA NOT IN (SELECT S.CODSIT FROM R010SIT S WHERE S.TIPSIT = 7);
 --***************************************
 WITH func_hc AS (
 SELECT 
        vrh.NUMCAD,
        P.COD_PACIENTE,          
        P.NOM_PACIENTE||' '|| P.SBN_PACIENTE NOME, 
       -- P.NOM_MAE, 
        P.DTA_NASCIMENTO, 
        P.IDF_SEXO, 
        FNC_CALCULA_TEMPO(SYSDATE, P.DTA_NASCIMENTO, 'aammdd') IDADE,
        VRH.NUMEMP,
        VRH.NUMLOC,
        X.LOCAL,
        EMP.APEEMP,
        car.TITRED
     /*   vac.DATA_VACINA, 
        vac.DSC_TIPO_VACINA, 
        vac.DSC_DOSE, 
        vac.STATUS, 
        vac.DSC_OBSERVACAO,        
        vac.NUM_LOTE_VACINA */                     
   FROM 
        PACIENTE P, 
        V_FUNCIONARIO_RUBI VRH,
        
        (SELECT * FROM (
        SELECT DISTINCT C.CODLOC,
                        A.NOMLOC,
                        C.CODLOC || ' - ' || A.NOMLOC AS LOCAL,
                        C.NUMLOC,                        
                        B.NUMEMP                       
          FROM R016ORN A, R034FUN B, R016HIE C
         WHERE B.NUMEMP IN (1,2,3,4,5,6,7)
           AND B.TIPCOL = 1
           AND B.SITAFA <> 7
           AND A.NUMLOC = B.NUMLOC
           AND A.NUMLOC = C.NUMLOC
           AND A.TABORG =
               (SELECT MAX(TABORG)
                  FROM R016ORN X
                 WHERE X.NUMLOC = B.NUMLOC
                   AND X.NUMLOC = C.NUMLOC
                   AND A.DATEXT = TO_DATE('31/12/1900', 'DD/MM/YYYY'))
             )) X,
             
             (SELECT 
                V.NOMEMP, 
                V.APEEMP, 
                V.NUMCGC, 
                V.NUMEMP, 
                V.SIGEMP
           FROM 
                V_EMPRESA_RUBI V ) EMP,
                
                
                ( SELECT
                      F.NUMEMP, -- EMPRESA 
                       F.NUMCAD,    
                      C.TITRED
                    FROM SENIOR.R034FUN F
                        LEFT JOIN R024CAR C ON C.ESTCAR = F.ESTCAR AND C.CODCAR = F.CODCAR
                        LEFT JOIN R030EMP E ON E.NUMEMP = F.NUMEMP
                    WHERE
                      F.TIPCOL = 1 -- sempre 1
                      -- filtro de demitido/admitido  
                      AND F.SITAFA NOT IN (SELECT S.CODSIT FROM R010SIT S WHERE S.TIPSIT = 7)) car                      
                      
        
     WHERE TRIM(TO_CHAR(VRH.NUMCPF,'00000000009')) = P.CPF_PACIENTE 
        AND VRH.NUMEMP          = X.NUMEMP
        AND VRH.NUMEMP    = EMP.NUMEMP
       AND VRH.NUMLOC          = X.NUMLOC 
       AND vrh.NUMCAD = car.NUMCAD
       AND vrh.NUMEMP = car.NUMEMP
       AND X.CODLOC IN ('DAS.8.12.1', 'DAS.8.12.2')
      
       --AND vac.COD_PACIENTE = p.cod_paciente
   /*ORDER BY X.LOCAL */)
   
   --***********************
   
   SELECT *
     FROM (SELECT fhc.*,         
        VN.DTA_VACINACAO DATA_VACINA, 
        TV.DSC_TIPO_VACINA, 
        D.DSC_DOSE, 
        ' Aplicada ' STATUS, 
        VN.DSC_OBSERVACAO,       
        to_char(l.NUM_LOTE_VACINA) NUM_LOTE_VACINA        
   FROM 
        VACINACAO VN, 
        PACIENTE_VACINACAO PV, 
        TIPO_VACINA TV, 
        DOSE D, 
        VACINA V, 
        PACIENTE P, 
        lote_vacina L,
        func_hc fhc 
  WHERE 
        VN.COD_PACIENTE_VACINACAO = PV.COD_PACIENTE_VACINACAO 
    --AND PV.COD_PACIENTE           = '1340268A' 
    AND VN.COD_TIPO_VACINA        = V.COD_TIPO_VACINA 
    AND VN.NUM_DOSE               = V.NUM_DOSE 
    AND V.COD_TIPO_VACINA         = TV.COD_TIPO_VACINA 
    AND V.NUM_DOSE                = D.NUM_DOSE 
    AND P.COD_PACIENTE            = PV.COD_PACIENTE 
    AND L.COD_LOTE_VACINA         = vn.cod_lote_vacina
    AND PV.COD_PACIENTE           = fhc.COD_PACIENTE
    AND tv.cod_tipo_vacina IN (3,5,6,8,9,15,16,19,26,55, 28,66 )
  --  AND  EXTRACT(YEAR FROM VN.DTA_VACINACAO) = 2017    
    UNION ALL 
 SELECT fhc.*,        
        AV.DTA_AGENDA_VACINACAO DATA_VACINA, 
        TV.DSC_TIPO_VACINA, 
        D.DSC_DOSE, 
        DECODE(AV.IDF_AGENDA_VACINACAO, 1, 'Agendado', 2, 'Confirmado', 3, 'Notificado', 4, 'Cancelado') STATUS, 
        '' DSC_OBSERVACAO,        
        '' NUM_LOTE_VACINA        
   FROM 
        AGENDA_VACINACAO AV, 
        PACIENTE_VACINACAO PV, 
        TIPO_VACINA TV, 
        DOSE D, 
        VACINA V, 
        PACIENTE P,
        func_hc fhc  
  WHERE 
        AV.DTA_AGENDA_VACINACAO  >= TRUNC(SYSDATE) 
    AND AV.COD_PACIENTE_VACINACAO = PV.COD_PACIENTE_VACINACAO 
    --AND PV.COD_PACIENTE           = '1340268A' 
    AND AV.COD_TIPO_VACINA        = V.COD_TIPO_VACINA 
    AND AV.NUM_DOSE               = V.NUM_DOSE 
    AND V.COD_TIPO_VACINA         = TV.COD_TIPO_VACINA 
    AND V.NUM_DOSE                = D.NUM_DOSE 
    AND P.COD_PACIENTE            = PV.COD_PACIENTE
    AND PV.COD_PACIENTE           = fhc.COD_PACIENTE
    AND tv.cod_tipo_vacina IN (3,5,6,8,9,15,16,19,26,55, 28,66 )
 --   AND  EXTRACT(YEAR FROM AV.DTA_AGENDA_VACINACAO) = 2017    
 UNION ALL 
         SELECT fhc.*,            
            COALESCE(VA.DTA_HOR_APLICACAO,UMAT.DTA_HOR_LANCAMENTO) DATA_VACINA, 
            TV.DSC_TIPO_VACINA,
            D.DSC_DOSE,
            DECODE(VA.IDF_STATUS, 0, 'CANCELADO', 1, 'AGUARDANDO', 2, 'APLICADA') STATUS,
            nvl(VA.DSC_JUSTIFICATIVA, ind.dsc_indicacao) DSC_OBSERVACAO,      
            L.NUM_LOTE_FABRICANTE NUM_LOTE_VACINA                   
       FROM PACIENTE                  P,
            VACINA_RECEPCAO           VR,
            VACINA_RECEPCAO_APLICACAO VA,
            DOSE                      D,
            INDICACAO_VACINA          IND,
            UTILIZACAO_MATERIAL       UMAT,
            INDICACAO_VACINA_MATERIAL INDMAT,
            TIPO_VACINA               TV,
            LOTE                      L,
            vacina_configuracao       vc, 
            estrategia_vacinacao      ev,
            func_hc fhc  
      WHERE VR.SEQ_VACINA_RECEPCAO = VA.SEQ_VACINA_RECEPCAO 
        AND VA.SEQ_UTILIZACAO_MATERIAL = UMAT.SEQ_UTILIZACAO_MATERIAL(+) 
        AND VA.NUM_DOSE = D.NUM_DOSE 
        AND VA.SEQ_IND_VACINA_MATERIAL = INDMAT.SEQ_IND_VACINA_MATERIAL(+) 
        AND INDMAT.SEQ_INDICACAO_VACINA = IND.SEQ_INDICACAO_VACINA(+) 
        AND VA.COD_TIPO_VACINA = TV.COD_TIPO_VACINA 
        AND UMAT.NUM_LOTE = L.NUM_LOTE(+) 
        AND VR.COD_PACIENTE = P.COD_PACIENTE 
        and va.seq_vacina_configuracao = vc.seq_vacina_configuracao 
        and vc.seq_estrategia_vacina = ev.seq_estrategia_vacina 
        --AND P.COD_PACIENTE = '1340268A'; 
        AND P.COD_PACIENTE = fhc.COD_PACIENTE
        AND tv.cod_tipo_vacina IN (3,5,6,8,9,15,16,19,26,55, 28,66 )
    --    AND  EXTRACT(YEAR FROM COALESCE(VA.DTA_HOR_APLICACAO,UMAT.DTA_HOR_LANCAMENTO)) = 2019 
         ) x
        ORDER BY x.NOME, X.dsc_tipo_vacina, x.DSC_dose;    
   --******************************
   
   
   
  

  
  /*lOCALIZA��O*/
  
  SELECT * FROM (
        SELECT DISTINCT C.CODLOC,
                        A.NOMLOC,
                        C.CODLOC || ' - ' || A.NOMLOC AS LOCAL,
                        C.NUMLOC
          FROM R016ORN A, R034FUN B, R016HIE C
         WHERE B.NUMEMP = 1
           AND B.TIPCOL = 1
           AND B.SITAFA <> 7
           AND A.NUMLOC = B.NUMLOC
           AND A.NUMLOC = C.NUMLOC
           AND A.TABORG =
               (SELECT MAX(TABORG)
                  FROM R016ORN X
                 WHERE X.NUMLOC = B.NUMLOC
                   AND X.NUMLOC = C.NUMLOC
                   AND A.DATEXT = TO_DATE('31/12/1900', 'DD/MM/YYYY'))
             ) X
             WHERE X.NOMLOC LIKE '%CENTRO DE TERAPIA%';
             
             
