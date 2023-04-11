{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('refined_employee_schema', '_airbyte_raw_dest_employee') }}
select
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['manager_id'], ['manager_id']) }} as manager_id,
    {{ json_extract_scalar('_airbyte_data', ['employee_id'], ['employee_id']) }} as employee_id,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['hire_date'], ['hire_date']) }} as hire_date,
    {{ json_extract_scalar('_airbyte_data', ['department'], ['department']) }} as department,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('refined_employee_schema', '_airbyte_raw_dest_employee') }} as table_alias
-- dest_employee
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

