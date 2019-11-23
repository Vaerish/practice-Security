import sys
import crypt

SysPass = open("Decoded.txt", "r")
contents = SysPass.read()
contents = contents.split('\n')
contents = contents[0].split(':')
print(contents[1])
