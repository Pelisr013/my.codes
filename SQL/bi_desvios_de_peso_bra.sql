WITH Base AS (
  SELECT
    Centro_WERKS AS ID_Centro,
    SAFE_CAST(NumeroDoProcesso_PROCESS AS INT64) AS Numero_Processo,
    FlagDeEliminado_FELIM AS Flag_De_Eliminado,

    DATE(DadaDoDocumento_AUDAT) AS Data_Do_Documento,
    DATE(CriarData_CREDAT) AS Data_Da_Criacao,

    Nome_TXTSP AS Transportadora,
    NomeDoMotorista_MOT_NAME AS Motorista,
    PlacaCarreta1_PLACA_1 AS Placa_Da_Carreta,
    Desvio_DESVIO AS Desvio,

    PesoLiquidoNf_PESO_LIQ_NF AS Peso_Liquido_NF,
    PesoCarga_PESO_CARGA AS Peso_Carga,
    PesoBrutoNf_PESO_BRU_NF AS Peso_Bruto_NF,

    TipoDeMaterial_TPMAT AS Codigo_Material,
    DescricaoTipoDeMaterial_TPDES AS Descricao_Do_Material,

    Descrica_Local_de_Descarga AS Local_de_Descarga,

    REPLACE(Status_STATUS_TXT, '%', 'C') AS Status,

    Operacao_OPERA_TXT AS Operacao,

    DataRegistrado_DT_00 AS Data_Registrado,
    HoraRegistrado_HR_00 AS Hora_Registrado    

  FROM `sz-dig-corp-business-prd.business_sap_pt_br.vw_ControledePortariaePesagem_FULL`
  WHERE NumeroDoProcesso_PROCESS IS NOT NULL
  AND CAST(Centro_WERKS AS STRING) IN ('1064','1101','1102','1110','1301','2100','2282',
           '2283','2298','5400','6100','6130','6300','6301','6303','6800','6810','6878')
  AND DATE(DadaDoDocumento_AUDAT) >= DATE '2025-01-01'
  AND DATE(DadaDoDocumento_AUDAT) < DATE '2026-07-01'

  UNION ALL

  -- SISTEMA S/4
  -- Dados a partir de 01/07/2026

  SELECT
    Centro_WERKS AS ID_Centro,
    SAFE_CAST(NumeroDoProcesso_PROCESS AS INT64) AS Numero_Processo,
    FlagDeEliminado_FELIM AS Flag_De_Eliminado,

    DATE(DadaDoDocumento_AUDAT) AS Data_Do_Documento,
    DATE(CriarData_CREDAT) AS Data_Da_Criacao,

    Nome_TXTSP AS Transportadora,
    NomeDoMotorista_MOT_NAME AS Motorista,
    PlacaCarreta1_PLACA_1 AS Placa_Da_Carreta,
    Desvio_DESVIO AS Desvio,

    PesoLiquidoNf_PESO_LIQ_NF AS Peso_Liquido_NF,
    PesoCarga_PESO_CARGA AS Peso_Carga,
    PesoBrutoNf_PESO_BRU_NF AS Peso_Bruto_NF,

    TipoDeMaterial_TPMAT AS Codigo_Material,
    DescricaoTipoDeMaterial_TPDES AS Descricao_Do_Material,

    Descrica_Local_de_Descarga AS Local_de_Descarga,

    REPLACE(Status_STATUS_TXT, '%', 'C') AS Status,

    Operacao_OPERA_TXT AS Operacao,

    DataRegistrado_DT_00 AS Data_Registrado,
    HoraRegistrado_HR_00 AS Hora_Registrado

  FROM `sz-dig-corp-business-prd.business_sap_s4_pt_br.vw_ControledePortariaePesagem_FULL`

  WHERE NumeroDoProcesso_PROCESS IS NOT NULL
    AND CAST(Centro_WERKS AS STRING) IN ('1064','1101','1102','1110','1301','2100','2282',
            '2283','2298','5400','6100','6130','6300','6301','6303','6800','6810','6878')
    AND DATE(DadaDoDocumento_AUDAT) > DATE '2026-07-01'
),
Deduplicado AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY Numero_Processo
      ORDER BY Data_Da_Criacao DESC
    ) AS rn
  FROM Base
),

Normalizado AS (
  SELECT
    *,

    TIMESTAMP(DATETIME(Data_Registrado, Hora_Registrado)) AS ts_registrado,

    ROUND(Desvio,2) AS Desvio_Ajustado

  FROM Deduplicado
  WHERE rn = 1
),

Metricas AS (
  SELECT

    *,

    CASE
      WHEN Peso_Carga IS NOT NULL
      AND Peso_Liquido_NF IS NOT NULL
      THEN Peso_Carga - Peso_Liquido_NF
      ELSE NULL
    END AS KG_Desvio,

    CASE
      WHEN Status IN (
          '09 Veículo Liberado',
          '10 Provisório',
          '11 Check Comprovei'
      )
      THEN NULL
      ELSE CONCAT(
            CAST(DIV(TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ts_registrado, SECOND), 86400) AS STRING),
            'd e ',
            CAST(
                DIV(
                    MOD(TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ts_registrado, SECOND), 86400),
                    3600
                ) AS STRING
            ),
            'h'
          )
    END AS TempoEmAberto,

    CASE
      WHEN (Status IS NULL OR Status NOT IN (
              '09 Veículo Liberado',
              '10 Provisório',
              '11 Check Comprovei'
          ))
      AND COALESCE(Flag_De_Eliminado, '') <> 'X'
      THEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ts_registrado, DAY)
      ELSE NULL
    END AS CPA,

    CASE
      WHEN UPPER(TRIM(COALESCE(Transportadora, ''))) = 'PORTAL SGS'
        OR UPPER(TRIM(COALESCE(Motorista, ''))) = 'PORTAL SGS'
        OR UPPER(TRIM(COALESCE(Placa_Da_Carreta, ''))) = 'SGS9999'
      THEN 'X'
      ELSE NULL
    END AS Flag_SGS,

    (
      [
        '< -80%',
        '-80 a -60',
        '-60 a -40',
        '-40 a -20',
        '-20 a -06',
        '-06 a -04',
        '-04 a -02',
        '-02 a 0',
        'OK',
        '0 a 02',
        '02 a 04',
        '04 a 06',
        '06 a 20',
        '20 a 40',
        '40 a 60',
        '60 a 80',
        '> 80%'
      ]
    )[OFFSET(
        RANGE_BUCKET(
          Desvio_Ajustado,
          [
          NUMERIC '-80',
          NUMERIC '-60',
          NUMERIC '-40',
          NUMERIC '-20',
          NUMERIC '-6',
          NUMERIC '-4',
          NUMERIC '-2',
          NUMERIC '0',
          NUMERIC '0.00001',
          NUMERIC '2',
          NUMERIC '4',
          NUMERIC '6',
          NUMERIC '20',
          NUMERIC '40',
          NUMERIC '60',
          NUMERIC '80'
          ]
        )
    )] AS Classe_Desvio

  FROM Normalizado
)

SELECT

ID_Centro,
Numero_Processo,
Flag_De_Eliminado,
Flag_SGS,
Data_Do_Documento,
Transportadora,
Codigo_Material,
Descricao_Do_Material,
Local_de_Descarga,
Status,
Operacao,
KG_Desvio,
Desvio,
Classe_Desvio,
ts_registrado,
Peso_Bruto_NF

FROM Metricas
