#!/usr/bin/env python3
import sys
from random import randint

count = 0
current_doc = None
 
for line in sys.stdin:
    doc, current_count = line.split("\t", 1)
    if doc != current_doc:
        if current_doc:
            socnet, url = current_doc.split("/")
            print(socnet, url, count, sep='\t')#'{}/{:016d}\t{}'.format(socnet,count,url))
        count = 0
        current_doc = doc
    count += int(current_count)
if current_doc:
    socnet, url = current_doc.split("/")
    print(socnet, url, count, sep='\t')
	#print('{}/{:016d}\t{}'.format(socnet, count, url))
