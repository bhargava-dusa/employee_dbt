{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('dest_employee_project_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'end_date',
        'project_id',
        'employee_id',
        'start_date',
    ]) }} as _airbyte_dest_employee_project_hashid,
    tmp.*
from {{ ref('dest_employee_project_ab2') }} tmp
-- dest_employee_project
where 1 = 1

