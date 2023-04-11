{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('refined_employee_schema', '_airbyte_raw_dest_skill') }}
select
    {{ json_extract_scalar('_airbyte_data', ['skill_name'], ['skill_name']) }} as skill_name,
    {{ json_extract_scalar('_airbyte_data', ['skill_id'], ['skill_id']) }} as skill_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('refined_employee_schema', '_airbyte_raw_dest_skill') }} as table_alias
-- dest_skill
where 1 = 1

