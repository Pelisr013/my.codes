WITH Base AS (

  -- SISTEMA LEGADO
  -- Dados de 01/01/2025 até 30/06/2026

  SELECT
    Centro_WERKS AS ID_Centro,
    SAFE_CAST(NumeroDoProcesso_PROCESS AS INT64) AS Numero_Processo,
    FlagDeEliminado_FELIM AS Flag_De_Eliminado,

    DATE(DadaDoDocumento_AUDAT) AS Data_Do_Documento,

    CodigoDaBalancaInicial_ZNUMBALI AS Codigo_Balanca_Inicial,
    CodigoDaBalancaFinal_ZNUMBALF AS Codigo_Balanca_Final,

    NomeDoMotorista_MOT_NAME AS Motorista,
    Nome_TXTSP AS Transportadora,
    Desvio_DESVIO AS Desvio,

    PesoLiquidoNf_PESO_LIQ_NF AS Peso_Liquido_NF,
    PesoBrutoNf_PESO_BRU_NF AS Peso_Bruto_NF,
    PesoCarga_PESO_CARGA AS Peso_Carga,

    PlacaCarreta1_PLACA_1 AS Placa_Da_Carreta,

    PesoInicial_PESO_INICIAL AS Peso_Inicial,
    PesoFinal_PESO_FINAL AS Peso_Final,

    DATE(CriarData_CREDAT) AS Data_Da_Criacao,
    HoraDaCriacao_CRETIM AS Hora_Da_Criacao,

    TipoDeMaterial_TPMAT AS Codigo_Material,
    DescricaoTipoDeMaterial_TPDES AS Descricao_Do_Material,
    Descrica_Local_de_Descarga AS Local_de_Descarga,
    REPLACE(Status_STATUS_TXT, '%', 'C') AS Status,
    Operacao_OPERA_TXT AS Operacao,

    DataRegistrado_DT_00 AS Data_Registrado,
    HoraRegistrado_HR_00 AS Hora_Registrado,

    DataPreEntrada_DT_01 AS Data_PreEntrada,
    HoraPreEntrada_HR_01 AS Hora_PreEntrada,

    DataChamado_DT_02 AS Data_Chamado,
    HoraChamado_HR_02 AS Hora_Chamado,

    DataEntrada_DT_03 AS Data_Entrada,
    HoraEntrada_HR_03 AS Hora_Entrada,

    DataInicioDescarregamento_DT_04 AS Data_Inicio_Descarregamento,
    HoraInicioDescarregamento_HR_04 AS Hora_Inicio_Descarregamento,

    DataFimDescarregamento_DT_05 AS Data_FimDescarregamento,
    HoraFimDescarregamento_HR_05 AS Hora_FimDescarregamento,

    DataPesoFinal_DT_06 AS Data_PesoFinal,
    HoraPesoFinal_HR_06 AS Hora_PesoFinal,

    DataVeiculoLiberado_DT_09 AS Data_VeiculoLiberado,
    HoraVeiculoLiberado_HR_09 AS Hora_Veiculo_Liberado

  FROM `sz-dig-corp-business-prd.business_sap_pt_br.vw_ControledePortariaePesagem_FULL`

  WHERE NumeroDoProcesso_PROCESS IS NOT NULL
    AND CAST(Centro_WERKS AS STRING) IN ('1064','6300','6301','6303')
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

    CodigoDaBalancaInicial_ZNUMBALI AS Codigo_Balanca_Inicial,
    CodigoDaBalancaFinal_ZNUMBALF AS Codigo_Balanca_Final,

    NomeDoMotorista_MOT_NAME AS Motorista,
    Nome_TXTSP AS Transportadora,
    Desvio_DESVIO AS Desvio,

    PesoLiquidoNf_PESO_LIQ_NF AS Peso_Liquido_NF,
    PesoBrutoNf_PESO_BRU_NF AS Peso_Bruto_NF,
    PesoCarga_PESO_CARGA AS Peso_Carga,

    PlacaCarreta1_PLACA_1 AS Placa_Da_Carreta,

    PesoInicial_PESO_INICIAL AS Peso_Inicial,
    PesoFinal_PESO_FINAL AS Peso_Final,

    DATE(CriarData_CREDAT) AS Data_Da_Criacao,
    HoraDaCriacao_CRETIM AS Hora_Da_Criacao,

    TipoDeMaterial_TPMAT AS Codigo_Material,
    DescricaoTipoDeMaterial_TPDES AS Descricao_Do_Material,
    Descrica_Local_de_Descarga AS Local_de_Descarga,
    REPLACE(Status_STATUS_TXT, '%', 'C') AS Status,
    Operacao_OPERA_TXT AS Operacao,

    DataRegistrado_DT_00 AS Data_Registrado,
    HoraRegistrado_HR_00 AS Hora_Registrado,

    DataPreEntrada_DT_01 AS Data_PreEntrada,
    HoraPreEntrada_HR_01 AS Hora_PreEntrada,

    DataChamado_DT_02 AS Data_Chamado,
    HoraChamado_HR_02 AS Hora_Chamado,

    DataEntrada_DT_03 AS Data_Entrada,
    HoraEntrada_HR_03 AS Hora_Entrada,

    DataInicioDescarregamento_DT_04 AS Data_Inicio_Descarregamento,
    HoraInicioDescarregamento_HR_04 AS Hora_Inicio_Descarregamento,

    DataFimDescarregamento_DT_05 AS Data_FimDescarregamento,
    HoraFimDescarregamento_HR_05 AS Hora_FimDescarregamento,

    DataPesoFinal_DT_06 AS Data_PesoFinal,
    HoraPesoFinal_HR_06 AS Hora_PesoFinal,

    DataVeiculoLiberado_DT_09 AS Data_VeiculoLiberado,
    HoraVeiculoLiberado_HR_09 AS Hora_Veiculo_Liberado

  FROM `sz-dig-corp-business-prd.business_sap_s4_pt_br.vw_ControledePortariaePesagem_FULL`

  WHERE NumeroDoProcesso_PROCESS IS NOT NULL
    AND CAST(Centro_WERKS AS STRING) IN ('1064','6300','6301','6303')
    AND DadaDoDocumento_AUDAT >= DATE '2026-07-01'
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
    TIMESTAMP(DATETIME(Data_PreEntrada, Hora_PreEntrada)) AS ts_preentrada,
    TIMESTAMP(DATETIME(Data_Chamado, Hora_Chamado)) AS ts_chamado,
    TIMESTAMP(DATETIME(Data_Entrada, Hora_Entrada)) AS ts_entrada,
    TIMESTAMP(DATETIME(Data_VeiculoLiberado, Hora_Veiculo_Liberado)) AS ts_saida,

    ROUND(Desvio,2) AS Desvio_Ajustado

  FROM Deduplicado
  WHERE rn = 1
),

Metricas AS (
  SELECT

    *,

    TIMESTAMP_DIFF(ts_entrada, ts_registrado, SECOND) AS TempoDePatio,
    TIMESTAMP_DIFF(ts_preentrada, ts_registrado, SECOND) AS TempoDeCP,
    TIMESTAMP_DIFF(ts_entrada, ts_chamado, SECOND) AS TME,
    TIMESTAMP_DIFF(ts_saida, ts_entrada, SECOND) AS TempoDeFabrica,
    TIMESTAMP_DIFF(ts_saida, ts_registrado, SECOND) AS TempoDeCiclo,

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
      WHEN (Status IS NULL OR Status NOT IN (
              '09 Veículo Liberado',
              '10 Provisório',
              '11 Check Comprovei'
          ))
      AND COALESCE(Flag_De_Eliminado, '') <> 'X'
      THEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ts_registrado, SECOND) / 86400.0
      ELSE NULL
    END AS CPA2,    

    CASE
      WHEN UPPER(TRIM(COALESCE(Transportadora, ''))) = 'PORTAL SGS'
        OR UPPER(TRIM(COALESCE(Motorista, ''))) = 'PORTAL SGS'
        OR UPPER(TRIM(COALESCE(Placa_Da_Carreta, ''))) = 'SGS9999'
      THEN 'X'
      ELSE NULL
    END AS Flag_SGS,

    COALESCE(
      Data_VeiculoLiberado,
      Data_PesoFinal,
      Data_FimDescarregamento,
      Data_Inicio_Descarregamento,
      Data_Entrada,
      Data_Chamado,
      Data_PreEntrada,
      Data_Registrado
    ) AS Ultima_Data_Processo,

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
Codigo_Balanca_Inicial,
Codigo_Balanca_Final,
Transportadora,
Placa_Da_Carreta,
Codigo_Material,
Descricao_Do_Material,
Local_de_Descarga,
Status,
Operacao,

Peso_Liquido_NF,
Peso_Bruto_NF,
Peso_Carga,
Peso_Inicial,
Peso_Final,

KG_Desvio,
Desvio,
Classe_Desvio,

ts_registrado,
TempoDePatio,
TempoDeCP,
TME,
TempoDeFabrica,
TempoDeCiclo,
TempoEmAberto,

CPA,
Ultima_Data_Processo,

(
  [
    'Hoje',
    '1 Dia',
    'Até 3 Dias',
    'Até 5 Dias',
    'Até 7 Dias',
    'Até 14 Dias',
    'Até 30 Dias',
    'Até 60 Dias',
    '> 60 dias'
  ]
)[OFFSET(
  RANGE_BUCKET(
    CPA2,
    [1.0,3.0,5.0,7.0,14.0,30.0,60.0]
  )
)] AS CPs_em_Aberto,

(
  RANGE_BUCKET(
    CPA2,
    [1.0,3.0,5.0,7.0,14.0,30.0,60.0]
  ) + 1.0
) AS Indice_CPs_em_Aberto

FROM Metricas
