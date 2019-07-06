#!/usr/bin/env python3
import sys
from random import randint

count = 0
current_doc = None
 
for line in sys.stdin:
    doc, current_count = line.split("\t", 1)
    if doc != current_doc:
        if current_doc:
            print(current_doc, count, sep = "\t")
        count = 0
        current_doc = doc
    count += int(current_count)
if current_doc:
    print(current_doc, count, sep = "\t")
