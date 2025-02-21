{{ config(materialized='table') }}

with quarterly_revenue as (
    select 
        service_type,
        pickup_year,
        pickup_quarter,
        pickup_year_quarter,
        sum(total_amount) as total_revenue
    from {{ ref('fact_trips') }} 
    where pickup_year >= 2019 AND pickup_year <= 2020
    group by 1, 2, 3, 4
),

quarterly_yoy_growth as (
    select 
        qr.*,
        lag(total_revenue) over (
            partition by pickup_quarter 
            order by pickup_year
        ) as prev_year_revenue,

        -- Handling NULL values in LAG() using IFNULL
        round(
            (total_revenue - IFNULL(lag(total_revenue) over (
                partition by pickup_quarter 
                order by pickup_year
            ), 0)) / NULLIF(IFNULL(lag(total_revenue) over (
                partition by pickup_quarter 
                order by pickup_year
            ), 0), 0) * 100, 2
        ) as yoy_growth_percentage
    from quarterly_revenue qr
)

select * from quarterly_yoy_growth
