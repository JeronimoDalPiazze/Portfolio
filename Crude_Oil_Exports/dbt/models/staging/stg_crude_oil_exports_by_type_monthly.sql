{{ config(materialized='table') }}

WITH source_data AS (
    SELECT *
    FROM read_csv_auto('{{ env_var("RAW_DATA_PATH") }}/crude-oil-exports-by-type-monthly.csv')
),
source_data_cte AS (
    SELECT
        CASE WHEN "Period" IS NULL THEN NULL ELSE CAST("Period" AS DATE) END AS period_date,
        CAST("Year" AS INTEGER) AS "year",
        LOWER(CAST("Month" AS VARCHAR)) AS month_name,
        LOWER(TRIM("Oil Type")) AS oil_type,
        CAST("Volume (m3/d)" AS DOUBLE) AS volume_cubic_meters_per_day,
        CAST("Volume (bbl/d)" AS DOUBLE) AS volume_barrels_per_day
    FROM source_data
)

SELECT *
FROM source_data_cte
WHERE oil_type <> 'total'
    AND (
        period_date IS NOT NULL
        OR volume_cubic_meters_per_day IS NOT NULL
        OR volume_barrels_per_day IS NOT NULL
    )