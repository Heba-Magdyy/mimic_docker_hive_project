#!/usr/bin/env python3
import sys

total = 0
count = 0

for line in sys.stdin:
    key, value = line.strip().split('\t')
    try:
        total += float(value)
        count += 1
    except:
        continue

if count > 0:
    print("Average Age at Death:", total / count)
else:
    print("No valid data")
