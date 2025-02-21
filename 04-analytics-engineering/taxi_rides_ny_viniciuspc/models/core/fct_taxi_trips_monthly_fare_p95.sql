{{ config(materialized='table') }}

with valid_trips as (
    select 
        service_type,
        pickup_year,
        pickup_month,
        fare_amount
    from {{ ref('fact_trips') }}
    where 
        fare_amount > 0
        and trip_distance > 0
        and payment_type_description in ('Cash', 'Credit Card')
), 

percentile_fares as (
    select 
        service_type,
        pickup_year,
        pickup_month,
        approx_quantiles(fare_amount, 100) as percentiles
    from valid_trips
    group by 1, 2, 3
)

select 
    service_type,
    pickup_year,
    pickup_month,
    percentiles[97] as p97_fare,
    percentiles[95] as p95_fare,
    percentiles[90] as p90_fare
from percentile_fares