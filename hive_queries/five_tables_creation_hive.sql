CREATE EXTERNAL TABLE IF NOT EXISTS patients (
  row_id INT,
  subject_id INT,
  gender STRING,
  dob TIMESTAMP,
  dod TIMESTAMP,
  expire_flag BOOLEAN
)
STORED AS PARQUET
LOCATION '/user/hive/projectFinalTest/patients/';





CREATE EXTERNAL TABLE IF NOT EXISTS diagnoses_icd (
  row_id INT,
  subject_id INT,
  hadm_id INT,
  seq_num INT,
  icd9_code STRING
)
STORED AS PARQUET
LOCATION '/user/hive/projectFinalTest/diagnoses_icd/';





CREATE EXTERNAL TABLE IF NOT EXISTS d_icd_diagnoses (
  row_id INT,
  icd9_code STRING,
  short_title STRING,
  long_title STRING
)
STORED AS PARQUET
LOCATION '/user/hive/projectFinalTest/d_icd_diagnoses/';

CREATE EXTERNAL TABLE IF NOT EXISTS admissions (
  row_id INT,
  subject_id INT,
  hadm_id INT,
  admittime TIMESTAMP,
  dischtime TIMESTAMP,
  deathtime TIMESTAMP,
  admission_type STRING,
  admission_location STRING,
  discharge_location STRING,
  insurance STRING,
  marital_status STRING,
  ethnicity STRING,
  edregtime TIMESTAMP,
  edouttime TIMESTAMP,
  diagnosis STRING,
  hospital_expire_flag BOOLEAN,
  has_chartevents_data BOOLEAN
)
STORED AS PARQUET
LOCATION '/user/hive/projectFinalTest/admissions/';




CREATE EXTERNAL TABLE IF NOT EXISTS icustays (
  row_id INT,
  subject_id INT,
  hadm_id INT,
  icustay_id INT,
  intime TIMESTAMP,
  outtime TIMESTAMP,
  los DOUBLE
)
STORED AS PARQUET
LOCATION '/user/hive/projectFinalTest/icustays/';