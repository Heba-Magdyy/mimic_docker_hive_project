# Project Overview

This project focuses on analyzing healthcare data using Apache Hive and MapReduce. It aims to extract meaningful insights from large datasets to improve healthcare outcomes.

## Technologies Used

- Docker
- Hadoop
- Hive
- Python

# Data Model

The data model for this project is designed to store and manage healthcare information efficiently. Detailed information about the data model, including column descriptions, data types, and relationships, can be found in the `data_model.md` file.

The main tables in the data model are:

- **admissions**: Stores information about patient admissions to the hospital.
- **patients**: Contains demographic information about the patients.
- **diagnoses_icd**: Links diagnoses (using ICD codes) to specific patient admissions.
- **d_icd_diagnoses**: Provides descriptions for ICD diagnosis codes.
- **icustays**: Records details about patient stays in the Intensive Care Unit (ICU).

# Setup Instructions

This section outlines the steps to set up the project environment. For detailed commands and specific paths, please refer to the `README.md` file.

## Prerequisites

- Docker
- Docker Compose
- Git

## Main Setup Steps

1.  **Clone Repositories**: Clone the necessary project repositories.
2.  **Start Docker Containers**: Use Docker Compose to start the required services (e.g., Hadoop, Hive).
3.  **Data Transfer**: Copy the data to the appropriate Docker container and then to HDFS.
4.  **Hive Setup**: Set up the Hive database and create the necessary tables.

# Running Analyses

This section describes how to execute Hive queries and MapReduce jobs for data analysis. For exact commands and detailed instructions, always refer to the `README.md` file.

## Hive Queries

Hive is used to query and analyze the structured data stored in HDFS.

-   **Table Creation**: The SQL statements for creating the necessary Hive tables are located in `hive_queries/five_tables_creation_hive.sql`.
-   **Analytical Queries**: The analytical queries are available in `hive_queries/Hive_queries.txt`.
-   **Query Results**: The output of these Hive queries will be stored in the `hive_queries/result/` directory. For example, the result for the first query can be found in `hive_queries/result/resultQ1.txt`, and so on for other queries.

## MapReduce Job (Average Age Calculation)

A MapReduce job is used to calculate the average age of patients.

1.  **Upload Files to HDFS**:
    *   Upload the mapper script: `hdfs dfs -put /path/to/your/repo/MapReduce_Average_Age/mapper.py /user/hduser/mapper.py`
    *   Upload the reducer script: `hdfs dfs -put /path/to/your/repo/MapReduce_Average_Age/reducer.py /user/hduser/reducer.py`
    *   Upload the patients data file: `hdfs dfs -put /path/to/your/repo/Data/patients.csv /user/hduser/patients.csv`
    *(Refer to `README.md` for the correct local paths to these files)*

2.  **Run the MapReduce Job**:
    Execute the following command (as provided in `README.md`):
    ```bash
    hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-*.jar \
    -D mapreduce.job.name="Average Age" \
    -files hdfs:///user/hduser/mapper.py,hdfs:///user/hduser/reducer.py \
    -mapper "/usr/bin/python3 mapper.py" \
    -reducer "/usr/bin/python3 reducer.py" \
    -input hdfs:///user/hduser/patients.csv \
    -output hdfs:///user/hduser/output/avg-age
    ```

3.  **Check Output**:
    To view the result of the MapReduce job, use the following command:
    ```bash
    hdfs dfs -cat /user/hduser/output/avg-age/part-00000
    ```
    This will display the calculated average age.

**Note**: Always consult the `README.md` for the most up-to-date and specific commands, paths, and troubleshooting information.

# MapReduce Components

The MapReduce job for calculating the average age of patients at death utilizes two main Python scripts: `MapReduce/mapper.py` and `MapReduce/reducer.py`. These scripts are executed as part of a Hadoop streaming job.

## `MapReduce/mapper.py`

The `MapReduce/mapper.py` script processes the input data (e.g., `patients.csv`) line by line.
- It expects comma-separated values and skips the header row.
- For each patient record, it extracts the date of birth (DOB) and date of death (DOD).
- If both DOB and DOD are present, it calculates the age of the patient in years (as a decimal value, considering leap years).
- It then outputs a key-value pair to standard output in the format `age\t<calculated_age>`. This output serves as the input for the reducer script.
- The script includes error handling to gracefully skip lines with unexpected formats or missing data.

## `MapReduce/reducer.py`

The `MapReduce/reducer.py` script receives the key-value pairs (e.g., `age\t<calculated_age>`) produced by the `mapper.py` script.
- It reads these pairs from standard input, expecting tab-separated values.
- It aggregates the ages by summing all the `calculated_age` values and counting the number of valid entries.
- Finally, it calculates the average age by dividing the total sum of ages by the total count of patients.
- The script outputs the final result as "Average Age at Death: [average_age]". If no valid data is processed, it outputs "No valid data".
- Error handling is included to skip any lines that do not conform to the expected format.

These two scripts work together within the Hadoop streaming framework to perform a distributed calculation of the average age from the patient dataset.

# Hive Queries

This section provides an overview of the Hive queries used for data analysis and table creation in this project.

## Analytical Queries (`hive_queries/Hive_queries.txt`)

The `hive_queries/Hive_queries.txt` file contains several HiveQL queries designed to perform various analyses on the healthcare data. These queries include, but are not limited to:
- Calculating the average length of stay for patients based on their diagnoses.
- Analyzing the distribution of ICU readmissions among patients.
- Determining mortality rates across different demographic groups (e.g., age and gender).

For the complete list of queries and their specific implementations, please refer directly to the `hive_queries/Hive_queries.txt` file. The results of these queries are typically stored in the `hive_queries/result/` directory, with filenames corresponding to the query (e.g., `resultQ1.txt`).

## Table Creation Script (`hive_queries/five_tables_creation_hive.sql`)

The `hive_queries/five_tables_creation_hive.sql` script contains the HiveQL Data Definition Language (DDL) statements required to create the necessary tables within the Hive database (typically within a database like `projectfinaltest` or similar, depending on setup).
This script defines the schema for each table (e.g., `patients`, `admissions`, `diagnoses_icd`, `d_icd_diagnoses`, `icustays`), specifying column names, data types, and how the tables map to the underlying Parquet data files stored in HDFS.

To understand the exact table structures and their HDFS locations, please consult the `hive_queries/five_tables_creation_hive.sql` file. This script is crucial for setting up the Hive environment before any analytical queries can be executed.
