{{ config(
    indexes = [{'columns':['_airbyte_unique_key'],'unique':True}],
    unique_key = "_airbyte_unique_key",
    schema = "refined_employee_schema",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('dest_employee_scd') }}
select
    _airbyte_unique_key,
    updated_at,
    manager_id,
    employee_id,
    last_name,
    hire_date,
    department,
    first_name,
    email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_dest_employee_hashid
from {{ ref('dest_employee_scd') }}
-- dest_employee from {{ source('refined_employee_schema', '_airbyte_raw_dest_employee') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

