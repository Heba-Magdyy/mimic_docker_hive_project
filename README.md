# MIMIC-III Hive & MapReduce Project

## 🚀 Overview
This project analyzes healthcare data using Apache Hive and MapReduce inside Docker.

## 🧱 Prerequisites

- Docker and Docker Compose installed
- Git

## 🔧 Setup Instructions

1. Clone my repo:
   `git clone https://github.com/Heba-Magdyy/mimic-docker-hive-project.git`
2. Clone this repo to use Docker Compose Repo:
   `git clone https://github.com/Marcel-Jan/docker-hadoop-spark`
   -To start the docker container make sure you are inside the dir(docker-hadoop-spark) and run
        `cd docker-hadoop-spark`
        `docker-compose up -d`

3. Open cmd and run
    docker cp path/of/data/from mimic-docker-hive-project namenode:/
    "This will copy the folder from your device to container"

   -To run the container:
    `docker exec -it namenode bash`

   -To copy files to HDFS
    `hdfs dfs -mkdir /user/hive/data`
    `hdfs dfs -put /data /user/hive/data`
    `hdfs dfs -ls /user/hive/data`    --->This to make sure files are there.

4. Open another cmd tab to use hive. Create database and tables.
     `docker exec -it hive-server bash`
     `hive`
     `CREATE DATABASE mimic;`
     `use mimic;`
    NOTE: Tables creation statements are in /hive_queries/five_tables_creation_hive.sql
    NOTE: update LOCATION according to your structure.
    NOTE: Make sure that LOCATION in your statements is the path of the folder which have the parquet file, not the path to file itself.

5. Execute hive queries to get measures."You would find it in hive_queries folder in txt file."


6. To Run the MapReduce job:
 -Upload Your Input File to HDFS
   "In new cmd tab"
    `docker cp mapreduce/mapper.py namenode:/data/`
    `docker cp mapreduce/reducer.py namenode:/data/`
    `docker cp data/patients.csv namenode:/data/`

   "after running the namenode container"
    `hdfs dfs -mkdir -p /user/input`
    `hdfs dfs -put /data/patients.csv /user/input`

-To Run MapReduce job
 `hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-*.jar \
  -input /user/input/patients.csv \
  -output /user/output/avg-age \
  -mapper "python3 /data/mapper.py" \
  -reducer "python3 /data/reducer.py" \
  -file /data/mapper.py \
  -file /data/reducer.py`

 -To check the output:
    `hdfs dfs -cat /user/hduser/output/avg-age/part-00000`

