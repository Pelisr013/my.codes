WITH Base AS (
  -- =========================================================================
  -- 1. SISTEMA LEGADO (ECC) - Dados até 30/06/2026
  -- =========================================================================
  SELECT
    Centro_WERKS AS ID_Centro,
    SAFE_CAST(NumeroDoProcesso_PROCESS AS INT64) AS Numero_Processo,
    NULLIF(TRIM(FlagDeEliminado_FELIM), '') AS Flag_De_Eliminado,

    DATE(DadaDoDocumento_AUDAT) AS Data_Do_Documento,

    NULLIF(TRIM(Nome_TXTSP), '') AS Transportadora,
    NULLIF(TRIM(NomeDoMotorista_MOT_NAME), '') AS Motorista,
    NULLIF(TRIM(PlacaCarreta1_PLACA_1), '') AS Placa_Da_Carreta,
    Desvio_DESVIO AS Desvio,

    PesoLiquidoNf_PESO_LIQ_NF AS Peso_Liquido_NF,
    PesoCarga_PESO_CARGA AS Peso_Carga,
    PesoBrutoNf_PESO_BRU_NF AS Peso_Bruto_NF,

    NULLIF(TRIM(TipoDeMaterial_TPMAT), '') AS Codigo_Material,
    NULLIF(TRIM(DescricaoTipoDeMaterial_TPDES), '') AS Descricao_Do_Material,

    NULLIF(TRIM(CodigoDaBalancaInicial_ZNUMBALI), '') AS Balanca_Inicial,
    NULLIF(TRIM(CodigoDaBalancaFinal_ZNUMBALF), '') AS Balanca_Final,

    NULLIF(TRIM(Descrica_Local_de_Descarga), '') AS Local_de_Descarga,
    NULLIF(TRIM(REPLACE(Status_STATUS_TXT, '%', 'C')), '') AS Status,
    NULLIF(TRIM(Operacao_OPERA_TXT), '') AS Operacao,

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

    CASE
      WHEN DataRecusado_DT_07 IS NULL
        OR DataRecusado_DT_07 <= DATE '1900-01-01'
      THEN NULL
      ELSE DataRecusado_DT_07
    END AS Data_Recusado,
    HoraRecusado_HR_07 AS Hora_Recusado,

    DataAprovado_DT_08 AS Data_Aprovado,
    HoraAprovado_HR_08 AS Hora_Aprovado,

    DataVeiculoLiberado_DT_09 AS Data_VeiculoLiberado,
    HoraVeiculoLiberado_HR_09 AS Hora_Veiculo_Liberado  

  FROM `sz-dig-corp-business-prd.business_sap_pt_br.vw_ControledePortariaePesagem_FULL`
  WHERE NumeroDoProcesso_PROCESS IS NOT NULL
    AND CAST(Centro_WERKS AS STRING) IN (
      '1064','1101','1102','1110','1301','2100','2282',
      '2283','2298','5400','6100','6130','6300','6301','6303','6800','6810','6878'
    )
    AND DATE(DadaDoDocumento_AUDAT) >= DATE '2025-01-01'
    AND DATE(DadaDoDocumento_AUDAT) < DATE '2026-07-01'

  UNION ALL

  -- =========================================================================
  -- 2. SISTEMA S/4HANA - Dados a partir de 01/07/2026
  -- =========================================================================
  SELECT
    Centro_WERKS AS ID_Centro,
    SAFE_CAST(NumeroDoProcesso_PROCESS AS INT64) AS Numero_Processo,
    NULLIF(TRIM(FlagDeEliminado_FELIM), '') AS Flag_De_Eliminado,

    DATE(DadaDoDocumento_AUDAT) AS Data_Do_Documento,

    NULLIF(TRIM(Nome_TXTSP), '') AS Transportadora,
    NULLIF(TRIM(NomeDoMotorista_MOT_NAME), '') AS Motorista,
    NULLIF(TRIM(PlacaCarreta1_PLACA_1), '') AS Placa_Da_Carreta,
    Desvio_DESVIO AS Desvio,

    PesoLiquidoNf_PESO_LIQ_NF AS Peso_Liquido_NF,
    PesoCarga_PESO_CARGA AS Peso_Carga,
    PesoBrutoNf_PESO_BRU_NF AS Peso_Bruto_NF,

    NULLIF(TRIM(TipoDeMaterial_TPMAT), '') AS Codigo_Material,
    NULLIF(TRIM(DescricaoTipoDeMaterial_TPDES), '') AS Descricao_Do_Material,

    NULLIF(TRIM(CodigoDaBalancaInicial_ZNUMBALI), '') AS Balanca_Inicial,
    NULLIF(TRIM(CodigoDaBalancaFinal_ZNUMBALF), '') AS Balanca_Final,

    NULLIF(TRIM(Descrica_Local_de_Descarga), '') AS Local_de_Descarga,
    NULLIF(TRIM(REPLACE(Status_STATUS_TXT, '%', 'C')), '') AS Status,
    NULLIF(TRIM(Operacao_OPERA_TXT), '') AS Operacao,

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

    CASE
      WHEN DataRecusado_DT_07 IS NULL
        OR DataRecusado_DT_07 <= DATE '1900-01-01'
      THEN NULL
      ELSE DataRecusado_DT_07
    END AS Data_Recusado,
    HoraRecusado_HR_07 AS Hora_Recusado,

    DataAprovado_DT_08 AS Data_Aprovado,
    HoraAprovado_HR_08 AS Hora_Aprovado,

    DataVeiculoLiberado_DT_09 AS Data_VeiculoLiberado,
    HoraVeiculoLiberado_HR_09 AS Hora_Veiculo_Liberado 

  FROM `sz-dig-corp-business-prd.business_sap_s4_pt_br.vw_ControledePortariaePesagem_FULL`
  WHERE NumeroDoProcesso_PROCESS IS NOT NULL
    AND CAST(Centro_WERKS AS STRING) IN (
      '1064','1101','1102','1110','1301','2100','2282',
      '2283','2298','5400','6100','6130','6300','6301','6303','6800','6810','6878'
    )
    AND DATE(DadaDoDocumento_AUDAT) >= DATE '2026-07-01'
),

Deduplicado AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY Numero_Processo
      ORDER BY Data_Do_Documento DESC
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
    TIMESTAMP(DATETIME(Data_Aprovado, Hora_Aprovado)) AS ts_aprovado,
    TIMESTAMP(DATETIME(Data_VeiculoLiberado, Hora_Veiculo_Liberado)) AS ts_saida,
    CASE
      WHEN Data_Recusado IS NULL
        OR Data_Recusado = DATE '0001-01-01'
      THEN NULL
      ELSE TIMESTAMP(DATETIME(Data_Recusado, Hora_Recusado))
    END AS ts_recusado,

    ROUND(Desvio, 2) AS Desvio_Ajustado

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
    TIMESTAMP_DIFF(ts_saida, ts_aprovado, SECOND) AS TempoDeLiberacao,
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
       AND Flag_De_Eliminado IS NULL
      THEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ts_registrado, DAY)
      ELSE NULL
    END AS CPA,

    CASE
      WHEN UPPER(Transportadora) = 'PORTAL SGS'
        OR UPPER(Motorista) = 'PORTAL SGS'
        OR UPPER(Placa_Da_Carreta) = 'SGS9999'
      THEN 'X'
      ELSE NULL
    END AS Flag_SGS,

    -- =======================================================================
    -- FLAG DE VALIDADE OPERACIONAL (1 = Valido, 0 = Expurgado)
    -- =======================================================================
    CASE
      WHEN Local_de_Descarga IN (
          '14 Virtual CDR',
          '20 CD AMERICANA',
          '22 CD AMERICANA CTR',
          '80 Suzanlog - Totem',
          '33 CDR SZ EXPEDIÇÃO',
          '82 Suzanlog - DSU1',
          '81 Triangulo',
          '86 Coopercarga',
          '41 Recebimento BC Infinity',
          '40 Expedição BC Infinity'
      )
        THEN true

      ELSE false
    END AS Flag_Valido,

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
  Flag_Valido,
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
  Data_Recusado,
  Balanca_Inicial,
  Balanca_Final,
  Peso_Bruto_NF,
  TempoDePatio,
  TempoDeCP,
  TME,
  TempoDeLiberacao,
  TempoDeFabrica,
  TempoDeCiclo
FROM Metricas;
