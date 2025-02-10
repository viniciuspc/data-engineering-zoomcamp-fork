-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `de-zoo.nytaxi.external_yellow_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://viniciuspc_dezoomcamp_hw3_2025/yellow_tripdata_2024-*.parquet']
);

-- Question 1 Check yellow trip data 20.332.093
SELECT count(1) FROM de-zoo.nytaxi.external_yellow_tripdata;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE de-zoo.nytaxi.yellow_tripdata_non_partitoned AS
SELECT * FROM de-zoo.nytaxi.external_yellow_tripdata;

-- Question 2
-- 155.12MB
SELECT COUNT(DISTINCT(PULocationID)) FROM de-zoo.nytaxi.yellow_tripdata_non_partitoned;
-- 0B
SELECT COUNT(DISTINCT(PULocationID)) FROM de-zoo.nytaxi.external_yellow_tripdata;

-- Question 3
-- 155.12MB
SELECT PULocationID FROM de-zoo.nytaxi.yellow_tripdata_non_partitoned;
-- 310,24MB
SELECT PULocationID, DOLocationID FROM de-zoo.nytaxi.yellow_tripdata_non_partitoned;

-- Question 4
-- 8.333
SELECT count(1) FROM de-zoo.nytaxi.external_yellow_tripdata WHERE fare_amount = 0;