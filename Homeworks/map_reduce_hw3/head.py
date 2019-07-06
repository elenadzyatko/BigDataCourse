#!/usr/bin/env python3
import sys
n=0
n_lines = 10
current_socnet =None
socnet_order = ['vk', 'facebook', 'odnoklassniki', 'twitter', 'reddit']
output = {socnet:[] for socnet in socnet_order}
 
for line in sys.stdin:
    socnet, url, count = line.strip().split("\t")
    if current_socnet != socnet:
        n=0
        current_socnet = socnet
        output[socnet] = []
    if n<n_lines:
        output[socnet].append(line.strip())
    n+=1

for socnet in socnet_order:
    for line in output[socnet]:
        print(line)
