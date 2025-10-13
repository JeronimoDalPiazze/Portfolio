{{ config(materialized='table') }}

WITH src AS (
  SELECT *
  FROM read_csv(
    '{{ env_var("RAW_DATA_PATH") }}/crude-oil-exports-data-dictionary.csv',
    columns = {'term':'VARCHAR','definition':'VARCHAR'},
    header = false
  )
)

SELECT
  TRIM(term) AS term,
  TRIM("definition") AS "definition",
FROM src