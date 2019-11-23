import sys
import crypt

to_hash = sys.argv[1]
to_salt = "$6$"+sys.argv[2]
password = crypt.crypt(to_hash, to_salt)
print(password)
