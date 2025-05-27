## Dimensions ##

### 1. `admissions`
- row_id (INT): "Internal identifier"
- subject_id (INT): "Patient ID"
- admittime (TIMESTAMP): "Date and time the patient was admitted"
- dischtime (TIMESTAMP): "Date and time the patient was discharged"
- deathtime (TIMESTAMP): "Date and time of death"
- admission_type (STRING): 
- admission_location (STRING): 
- discharge_location (STRING)
- insurance (STRING)
- marital_status (STRING)
- ethnicity (STRING)
- edregtime (TIMESTAMP): "Time the patient was registered in the emergency department (ED)"
- edouttime (TIMESTAMP): "Time the patient left the ED to be admitted or discharged"
- diagnosis (STRING)
- hospital_expire_flag (BOOLEAN): "1 if the patient died during this hospital stay, 0 otherwise"
- has_chartevents_data (BOOLEAN): "1 if there is associated chart data (in CHARTEVENTS table) for this hospital"


### 2. `patients`
- row_id (INT): "Internal identifier"
- subject_id (INT): "Patient ID"
- gender (STRING)
- dob (TIMESTAMP): "Date of birth"
- dod (TIMESTAMP): "Date of death"
- expire_flag BOOLEAN


### 3. `diagnoses_icd`
- row_id (INT): "Internal identifier"
- subject_id (INT): "Patient ID"
- hadm_id (INT): "hospital admission ID"
- seq_num (INT)
- icd9_code (STRING)


### 4. `d_icd_diagnoses`
- row_id (INT): "Internal identifier"
- icd9_code (STRING)
- short_title (STRING)
- long_title (STRING)


### 5. `icustays`
- row_id (INT): "Internal identifier"
- subject_id (INT): "Patient ID"
- hadm_id (INT): "hospital admission ID"
- icustay_id (INT)
- intime (TIMESTAMP): "Date and time the patient entered the ICU."
- outtime (TIMESTAMP): "Date and time the patient exited the ICU."
- los (DOUBLE): "Length of stay in the ICU in days"


## Relationships ##

- `admissions.hadm_id` → `diagnoses_icd.hadm_id`
- `diagnoses_icd.icd9_code` → `d_icd_diagnoses.icd9_code`


## Measures

- Average age (from MapReduce job)
- Average length of stay per diagnosis.
- Distribution of ICU readmissions
- Mortality rates by demographic groups