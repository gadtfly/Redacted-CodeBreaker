module Main where
import Data.Char
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Base64 as Base64

secret_message :: IO String
secret_message = fmap (BS.unpack . Base64.decodeLenient . BS.pack) $ readFile "ciphertext"

dict :: IO [String]
dict = fmap lines $ readFile "/usr/share/dict/words"

code :: (Int -> Int -> Int) -> String -> String -> String
code f text key = zipWith codeChar text $ cycle key
  where
    codeChar c0 c1 = chr $ mod (f (ord c0) (ord c1)) 256

encode :: String -> String -> String
encode = code (+)

decode :: String -> String -> String
decode = code (-)

crack :: String -> [String] -> String
crack ciphertext candidateKeys = head $ heuristic $ map (decode ciphertext) candidateKeys
  where
    -- Cheating: longer message allows simplistic heuristic
    heuristic = filter (all isPrint)

main :: IO ()
main = do
  ciphertext    <- secret_message
  candidateKeys <- dict
  let plaintext = crack ciphertext candidateKeys
  print plaintext
  writeFile "plaintext" plaintext
