#!/usr/bin/env python3
import sys
from random import randint

for line in sys.stdin:
    url, socnets = line.strip().split("\t")
    url = url.split("//")[1]
    url = url.split("/")[0]
    if url[:4] == 'www.':
        url = url[4:]
    socnets = socnets.split(";")
    for net in socnets:
        net, count = net.split(":")
        print(net+"/"+url,count ,sep ="\t")
    #print('{:016d}_{}\t1'.format(randint(1, int(1e16)),id))

