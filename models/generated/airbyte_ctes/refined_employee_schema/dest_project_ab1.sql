{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('refined_employee_schema', '_airbyte_raw_dest_project') }}
select
    {{ json_extract_scalar('_airbyte_data', ['end_date'], ['end_date']) }} as end_date,
    {{ json_extract_scalar('_airbyte_data', ['project_id'], ['project_id']) }} as project_id,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['project_name'], ['project_name']) }} as project_name,
    {{ json_extract_scalar('_airbyte_data', ['start_date'], ['start_date']) }} as start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('refined_employee_schema', '_airbyte_raw_dest_project') }} as table_alias
-- dest_project
where 1 = 1

