-- I used kestra backfill from week 2 to load the csv files.
-- fhv
CREATE OR REPLACE EXTERNAL TABLE `de-zoo.trips_data_all_hw.external_fhv_tripdata`
OPTIONS (
  format = 'csv',
  uris = ['gs://kestra-bucket-viniciuspc/fhv_tripdata_2019-*.csv']
);

CREATE OR REPLACE TABLE de-zoo.trips_data_all_hw.fhv_tripdata AS
SELECT * FROM de-zoo.trips_data_all_hw.external_fhv_tripdata;

-- green
CREATE OR REPLACE EXTERNAL TABLE `de-zoo.trips_data_all_hw.external_green_tripdata`
OPTIONS (
  format = 'csv',
  uris = ['gs://kestra-bucket-viniciuspc/green_tripdata_2019-*.csv', 
          'gs://kestra-bucket-viniciuspc/green_tripdata_2020-*.csv']
);

CREATE OR REPLACE TABLE de-zoo.trips_data_all_hw.green_tripdata AS
SELECT * FROM de-zoo.trips_data_all_hw.external_green_tripdata;

-- yellow
CREATE OR REPLACE EXTERNAL TABLE `de-zoo.trips_data_all_hw.external_yellow_tripdata`
OPTIONS (
  format = 'csv',
  uris = ['gs://kestra-bucket-viniciuspc/yellow_tripdata_2019-*.csv', 
          'gs://kestra-bucket-viniciuspc/yellow_tripdata_2020-*.csv']
);

CREATE OR REPLACE TABLE de-zoo.trips_data_all_hw.yellow_tripdata AS
SELECT * FROM de-zoo.trips_data_all_hw.external_yellow_tripdata;