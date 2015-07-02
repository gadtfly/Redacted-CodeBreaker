#
# Code Breaker!
#
# You've intercepted a secret message, encrypted with the encryption
# algorithm below. The encryption key is unknown, but is a standard
# dictionary word. Can you break the code and recover the message?

secret_message = """
ydbYleXlz5PqxteV4dve4NnP2pPU0pXi29qS48bUn4W33dfh3uDXgerc2cyVz9/hktjK5pPSzdzW
56+SuMaT187Ildbc6JLmxuXshcba4eeV5t+B4NTQyZXC29qS0srf39Tb6I7m4uHf1duTxtLZjtXn
29fJ56CShLbc15Xm2Mrmk9zF6I7i2dacgdXYyMXq4diV2+SB6tTYhMnW2JXf2cXX38qE5NST6drV
geHczMzpnJOVxtjGk+DU0+OO6tblkNTb3NPN49WT6OfczNzf3pCVsNjY0+XU2JPYzNqO593h5cjb
54XY3dOT6OfegbvUyYTc3eeV4N+B1ejYzePT5uiS5NCT1cqE6dbY59eQotnnytaV4tvaktTC7JPc
xeiO1+Tg1Y6gk4et6ZXmlejV0+yT19nZ05Pk2JDJ3OCRhpXh29qS48Lc15GEl8LildXfztiTxtLZ
jubl4dnNk+fNyZXU6OOTkoGTk7nM2o7m2tOQ2NTmhdva4pPW5ZDY2OeFx+Tj39mS0safk7nM2o7m
1uDU1JPqytbajtfn65DC5pPJ1u6ck87h5YHW4trQ2Y7h5OaQ1NjYhcWV0d/k59SNk9XKx9bj5tqS
vtCT1tHT6tKT7NPjgdzhhdjd05Po3embk8HUhNfX5dnlkNjY5cqE29rs3uDXgeLpytbd09TZn52B
x9vK1tqO6trk1YHh4oXG3uDX6JLk0JPZ0d2jjpPJ2tWBytTR1urhk9bg1IHn28qEuM/l5dfe1djl
hbva4NiV6dHN3tzTy5XR3+Tl1YHU54XM1tzXsJLEydjshdva3ueV3tnM2JPG0u7i297g14Hn4oXX
2tOTyOfTyZPk2sXj4tzp29XUk+LLhOjP4dmskIO82YXY3dfmlenV09iT1NLh55PY3tXC5djJhNbl
1O6ekoHH28rdleHU3tacgZXc2YTs3ejh1pDD2JPM1tbc15aUkIGVvMuE6NPp2uCQztTcydeV5dzp
2pDU2OnK0pXb4uXlkLTq2NXYldfnldjf05PbxtDbjtSV69XC5aGFqOSO7OTnkNTo49XT6NOfl5Lk
ydiTvMXh4OjokuPC3NeRhJfC29bmkNXb2N6E2N3o4daQyNjnhc3pjtbh19HTspWFhr6O1+Tn0tWT
3NmQl47m1tvUgefbyoS4z+Xl197V2OWRhLbc15Xl2MbXk8aE19fn6dfigefYxtaj"""

def super_duper_encode(plaintext, key):
  ciphertext = ''
  for i in range(len(plaintext)):
    character = plaintext[i]
    key_char = key[i % len(key)]
    # ord(character) returns the integer character code of the specified character
    cipher_character = (ord(character) + ord(key_char)) % 256
    ciphertext += chr(cipher_character)
  return ciphertext.encode('base64')


def super_duper_decode(ciphertext, key):
  ciphertext = ciphertext.decode('base64')
  plaintext = ''
  for i in range(len(ciphertext)):
    character = ciphertext[i]
    key_char = key[i % len(key)]
    plain_character = (ord(character) - ord(key_char)) % 256
    plaintext += chr(plain_character)
  return plaintext



import sys

# lol... I think this isn't quite idiomatic
if __name__ == '__main__':
  print(globals()['super_duper_%s' % sys.argv[1]](*sys.argv[2:]))
