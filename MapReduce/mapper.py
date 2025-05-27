#!/usr/bin/env python3
import sys
from datetime import datetime

for line in sys.stdin:
    try:
        parts = line.strip().split(',')
        if parts[0] == "subject_id":
            continue  # Skip header
        dob = parts[2]
        dod = parts[3]
        if dob and dod:
            dob_dt = datetime.strptime(dob, "%Y-%m-%d")
            dod_dt = datetime.strptime(dod, "%Y-%m-%d")
            age = (dod_dt - dob_dt).days / 365.25
            print(f"age\t{age}")
    except Exception as e:
        continue
