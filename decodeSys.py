import sys
import crypt

SysPass = open("Decoded.txt", "r")
contents = SysPass.read()
contents = contents.split('=>')
contents = contents[-1]
contents = contents.split('/n')
contents = contents[0].split(':')
contents = contents[1].split()
print(contents[0])