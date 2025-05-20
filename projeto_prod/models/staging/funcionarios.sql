with calc_funcionarios as (
    select
    -- anos de idade exata
    DATE_DIFF(current_date, birth_date, YEAR) - IF(EXTRACT(MONTH FROM current_date) < EXTRACT(MONTH FROM birth_date)
                                                    OR (EXTRACT(MONTH FROM current_date) = EXTRACT(MONTH FROM birth_date) 
                                                    AND EXTRACT(DAY FROM current_date) < EXTRACT(DAY FROM birth_date)
                                                    ),
                                                1, 0) 
        AS age,
    -- anos de trabalho exato
    DATE_DIFF(current_date, hire_date, YEAR) - IF(EXTRACT(MONTH FROM current_date) < EXTRACT(MONTH FROM hire_date)
                                                    OR (EXTRACT(MONTH FROM current_date) = EXTRACT(MONTH FROM hire_date) 
                                                    AND EXTRACT(DAY FROM current_date) < EXTRACT(DAY FROM hire_date)
                                                    ),
                                                1, 0) 
        AS lengthofservice,
    first_name || ' ' || last_name as full_name,
    *
    from {{ source('sources', 'employees') }}
)

select *
from calc_funcionarios
