{{
    config(
        materialized='table',
        post_hook=[
            "
                GRANT USAGE ON SCHEMA {{target.schema}} TO bi_user;
                GRANT SELECT ON TABLE {{target.schema}}.bireport TO bi_user;
            "
        ]
    )
}}


select *
from {{ ref('joins') }}
