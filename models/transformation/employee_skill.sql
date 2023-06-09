with employee as (
    select 
        employee_id as id,
        concat(first_name, ' ', last_name) as full_name
    from {{ ref('dest_employee') }}
),

skill as (
    select 
        skill_name as s_name,
        skill_id as id
    from {{ ref('dest_skill') }}
),

employee_skill as (
    select 
        employee_id as e_id,
        skill_id as s_id
    from {{ ref('dest_employee_skill') }}
),

final as (
    select 
        e.full_name as employee_name,
        STRING_AGG(s.s_name, ', ') as skills
    from employee e
    left join employee_skill es on e.id = es.e_id
    left join skill s on es.s_id = s.id
    group by e.id, e.full_name
)

select * from final