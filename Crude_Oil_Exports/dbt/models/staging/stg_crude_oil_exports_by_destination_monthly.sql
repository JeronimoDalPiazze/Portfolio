{{ config(materialized='table') }}

WITH source_data AS (
    SELECT *
    FROM read_csv_auto('{{ env_var("RAW_DATA_PATH") }}/crude-oil-exports-by-destination-monthly.csv')
)

SELECT
    CASE WHEN "Period" IS NULL THEN NULL ELSE CAST("Period" AS DATE) END AS period_date,
    CAST("Year" AS INTEGER) AS "year",
    LOWER("Month") AS month_name,
    PADD AS destination,
    CAST(NULLIF(LOWER("Volume (m3/d)"), 'confidential') AS DOUBLE) AS volume_cubic_meters_per_day,
    CAST(NULLIF(LOWER("Volume (bbl/d)"), 'confidential') AS DOUBLE) AS volume_barrels_per_day
FROM source_data
WHERE period_date IS NOT NULL
    AND destination IS NOT NULL
    OR volume_cubic_meters_per_day IS NOT NULL
    OR volume_barrels_per_day IS NOT NULL