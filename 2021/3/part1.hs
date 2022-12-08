import Data.List
import Data.Bits

parse :: String -> [[Int]]
parse = map (map (read . return)) . lines

mostCommonBit :: [Int] -> Int
mostCommonBit bits = if sum bits > (length bits `div` 2) then 1 else 0

bitsToInt :: [Int] -> Int
bitsToInt = sum . zipWith (flip shift) [0..] . reverse

run :: [[Int]] -> Int
run list = gamma * epsilon
  where gamma = bitsToInt . map mostCommonBit . transpose $ list
        bitCount = length $ head list
        max' = 1 `shift` bitCount - 1
        epsilon = max' - gamma

main = getContents >>= putStrLn . show . run . parse
