import sys
import crypt

def to_hash_fun(var1, var2):
	to_hash = var1
	to_salt = "$6$"+var2
	password = crypt.crypt(to_hash, to_salt)
	return password

dictionary = sys.argv[1]
hashBoss = sys.argv[2]
saltBoss = sys.argv[3]

dictionary = open(dictionary,"r")
dictionary = dictionary.read()
newDictionary = dictionary.split()
for word in newDictionary:
	test=to_hash_fun(word, saltBoss)
	if(test == hashBoss):
		print(word)
		break
