#!/usr/bin/env python3
import sys
from random import randint

N_col = randint(1,5)
buffer = []
for line in sys.stdin:
    id = line.split("\t", 1)
    buffer.append(id[0].split("_")[1])
    if len(buffer)==N_col:
        print(",".join(buffer))
        buffer = []
        N_col = randint(1,5)
print(",".join(buffer))
