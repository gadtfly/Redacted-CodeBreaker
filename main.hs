module Main where
import Data.Char

secret_message = "ydbYleXlz5PqxteV4dve4NnP2pPU0pXi29qS48bUn4W33dfh3uDXgerc2cyVz9/hktjK5pPSzdzW56+SuMaT187Ildbc6JLmxuXshcba4eeV5t+B4NTQyZXC29qS0srf39Tb6I7m4uHf1duTxtLZjtXn29fJ56CShLbc15Xm2Mrmk9zF6I7i2dacgdXYyMXq4diV2+SB6tTYhMnW2JXf2cXX38qE5NST6drVgeHczMzpnJOVxtjGk+DU0+OO6tblkNTb3NPN49WT6OfczNzf3pCVsNjY0+XU2JPYzNqO593h5cjb54XY3dOT6OfegbvUyYTc3eeV4N+B1ejYzePT5uiS5NCT1cqE6dbY59eQotnnytaV4tvaktTC7JPcxeiO1+Tg1Y6gk4et6ZXmlejV0+yT19nZ05Pk2JDJ3OCRhpXh29qS48Lc15GEl8LildXfztiTxtLZjubl4dnNk+fNyZXU6OOTkoGTk7nM2o7m2tOQ2NTmhdva4pPW5ZDY2OeFx+Tj39mS0safk7nM2o7m1uDU1JPqytbajtfn65DC5pPJ1u6ck87h5YHW4trQ2Y7h5OaQ1NjYhcWV0d/k59SNk9XKx9bj5tqSvtCT1tHT6tKT7NPjgdzhhdjd05Po3embk8HUhNfX5dnlkNjY5cqE29rs3uDXgeLpytbd09TZn52Bx9vK1tqO6trk1YHh4oXG3uDX6JLk0JPZ0d2jjpPJ2tWBytTR1urhk9bg1IHn28qEuM/l5dfe1djlhbva4NiV6dHN3tzTy5XR3+Tl1YHU54XM1tzXsJLEydjshdva3ueV3tnM2JPG0u7i297g14Hn4oXX2tOTyOfTyZPk2sXj4tzp29XUk+LLhOjP4dmskIO82YXY3dfmlenV09iT1NLh55PY3tXC5djJhNbl1O6ekoHH28rdleHU3tacgZXc2YTs3ejh1pDD2JPM1tbc15aUkIGVvMuE6NPp2uCQztTcydeV5dzp2pDU2OnK0pXb4uXlkLTq2NXYldfnldjf05PbxtDbjtSV69XC5aGFqOSO7OTnkNTo49XT6NOfl5LkydiTvMXh4OjokuPC3NeRhJfC29bmkNXb2N6E2N3o4daQyNjnhc3pjtbh19HTspWFhr6O1+Tn0tWT3NmQl47m1tvUgefbyoS4z+Xl197V2OWRhLbc15Xl2MbXk8aE19fn6dfigefYxtaj"

code :: (Int -> Int -> Int) -> String -> String -> String
code f text key = zipWith codeChar text $ cycle key
  where
    codeChar c0 c1 = chr $ mod (f (ord c0) (ord c1)) 256

encode :: String -> String -> String
encode = code (+)

decode :: String -> String -> String
decode = code (-)

main :: IO ()
main = print $ decode (encode "asdf" "qwer") "qwer"
