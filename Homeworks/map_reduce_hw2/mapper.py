#!/usr/bin/env python3
import sys
from random import randint

for line in sys.stdin:
    id = line.strip()
    print('{:016d}_{}\t1'.format(randint(1, int(1e16)),id))

