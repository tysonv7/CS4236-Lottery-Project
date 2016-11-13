#!/usr/bin/python
import sys

outputstr = ""

for line in sys.stdin:
    outputstr += line.strip()
    outputstr += " "

print(outputstr)
