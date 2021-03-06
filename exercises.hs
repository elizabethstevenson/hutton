import Data.Char



-- Chapter 1: Basic Concepts --


-- 1.7 Exercises --


-- 1. Give another possible calculation for the result of double (double 2).
double x =
  x + x

quadruple x =
  double (double x)


-- 3: Define a function product that produces a product of a list of numbers, and shw using your definition that product [2,3,4] is 24.
product2 []     = 1
product2 (n:ns) = (*) n (product2 ns)


-- 4: How should the definition of qsort be modified so that it produces a reverse sorted version of a list.
qsortReverse :: Ord(a) => [a] -> [a]
qsortReverse [] = []
qsortReverse (x:xs) = 
     (qsortReverse [b | b <- xs, b > x]) 
  ++ [x] 
  ++ (qsortReverse [a | a <- xs, a <= x])


-- 5: What would the effect be of replacing <= with < in the original definition of qsort?
qsort2 :: Ord(a) => [a] -> [a]
qsort2 [] = []
qsort2 (x:xs) = 
     (qsort [a | a <- xs, a < x]) 
  ++ [x] 
  ++ (qsort [b | b <- xs, b > x])



-- Chapter 2: First steps --

-- 2.7 Exercises --

-- 4. Show how the library function last could be defined in terms of other library functions introduced in this chapter. Can you think of another possible definition?
fnLast1 :: [t] -> t
fnLast1 xs = head (reverse xs)

fnLast2 :: [t] -> t
fnLast2 xs = head (drop (length xs - 1) xs)

fnLast3 :: [t] -> t
fnLast3 xs = xs !! (length xs-1)

-- 5. Show how the library function init could be defined in two different ways.
fnInit1 :: [t] -> [t]
fnInit1 xs = take (length xs - 1) xs

fnInit2 :: [t] -> [t]
fnInit2 xs = reverse (tail (reverse xs))



-- Chapter 3: Types and Classes --


-- 3.11 Exercises --


-- 1 What are the types of the following values?
ex1 = ['a','b','c'] :: [Char]
ex2 = ('a','b','c') :: (Char, Char, Char)
ex3 = [(False, '0'), (True, '1')] :: [(Bool, Char)]
ex4 = ([False, True], ['0', '1']) :: ([Bool], [Char])
ex5 = [tail, init, reverse] :: [[a] -> [a]]


-- 2 Write down definitions that have the following types.
bools :: [Bool]
bools = [False, True]

nums :: [[Int]]
nums = [[1,2,3], [2,4,6], [3,6,9]]

exAdd :: Int -> Int -> Int -> Int
exAdd = \x -> \y -> \z -> x+y+z

exCopy :: a -> (a,a)
exCopy x = (x, x)

exApply :: (a -> b) -> a -> b
exApply a b = a b


-- 3 What are the types of the following functions?
second :: [a] -> a
second xs = head (tail xs)

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

pair :: a -> b -> (a, b)
pair x y = (x,y)

exDouble :: Num a => a -> a
exDouble x = x*2

palindrome :: String -> Bool
palindrome xs = reverse xs == xs




-- Chapter 4: Defining functions --


-- 4.8 Exercises --


-- 1. Using library functions define a function halve :: [a] -> ([a],[a]) that splits an even-lengthed list into two halves.
halve :: [a] -> ([a], [a])
halve [] = ([],[])
halve xs = (take ((length xs) `div` 2) xs, drop ((length xs) `div` 2) xs)

halve' :: [a] -> ([a], [a])
halve' xs = (take n xs, drop n xs)
              where n = (length xs) `div` 2

halve'' :: [a] -> ([a], [a])
halve'' xs = splitAt n xs
              where n = (length xs) `div` 2

-- 2. Define a function third :: [a] -> a that returns the third element in a list that contains at least this many elements using:
-- a. head and tail;
-- b. list indexing !!;
-- c. pattern matching.
thirdA :: [a] -> a
thirdA xs = head (tail (tail xs))

thirdB :: [a] -> a
thirdB xs = xs !! 2

thirdC :: [a] -> a
thirdC (x:x2:x3:xs) = x3


-- 3. Consider a function safetail :: [a] -> [a] that behaves the same way as tail does except that it maps the empty list to itself rather than producing an error.
-- Using tail and the function null :: [a] -> Bool that decides if a list is empty or not, define safetail using:
-- a. a conditional expression;
-- b. guarded equations;
-- c. pattern matching.

-- a. a conditional expression;
safetail_a :: [a] -> [a]
safetail_a xs = 
  if listNull xs
    then []
    else tail xs

-- b. guarded equations;
safetail_b :: [a] -> [a]
safetail_b xs 
  | listNull xs = []
  | otherwise = tail xs

-- c. pattern matching.
safetail_c :: [a] -> [a]
safetail_c [] = []
safetail_c (_:xs) = xs


-- 4. In a similar way to && in section 4.4, show how the disjunction operator || can be defined in four different ways using pattern matching.
or_logical :: Bool -> Bool -> Bool
or_logical False False = False
or_logical False True = True
or_logical True False = True
or_logical True True = True

or_logical2 :: Bool -> Bool -> Bool
or_logical2 False False = False
or_logical2 True _ = True

or_logical3 :: Bool -> Bool -> Bool
or_logical3 False b = b
or_logical3 True b = True

or_logical4 :: Bool -> Bool -> Bool
or_logical4 b b1 
    | b == b1 = b
    | otherwise = True

listNull :: [a] -> Bool
listNull [] = True
listNull xs = False
  

-- 7. Show how the meaning of the following curried functions definition can be formalised in terms of lambda expressions.
multL :: Int -> Int -> Int -> Int
-- multL x y z = x * y * z
multL = \x -> \y -> \z -> x * y * z

-- 8. Define a function luhnDouble::Int->Int that doubles a digit and subtracts 9 if the result is greater than 9.
-- Using luhnDouble and `mod`, define a function luhn::Int->Int->Int->Int->Bool that decides if a four-digit bank card number is valid.
luhn :: Int -> Int -> Int -> Int -> Bool
luhn i j k l 
  | mod (luhnDouble i + j + luhnDouble k + l) 10 == 0 = True
  | otherwise = False


luhnDouble :: Int -> Int
luhnDouble n 
    | n*2 < 9   = n*2
    | otherwise = (n*2 - 9)




-- Chapter 5: List Comprehensions --


-- 5.7 Exercises --


-- 1. Using a list comprehension, give an expression that calculates the sum
-- 1^2 + 2^2 _ ... + 100^2 of the first 100 integer squares.
sumOfSquares :: Integer
sumOfSquares = sum [x^2 | x <- [1..100]]


-- 2. Using a list comprehension, define a function grid :: Int -> Int -> [(Int,Int)]
-- that returns a coordinate grid of a given size.
grid :: Int -> Int -> [(Int,Int)]
grid m n = [(x,y) | x <- [0..m], y <- [0..n]]


-- 3. Using a list comprehension and the function grid above, 
-- define a function square :: Int -> [(Int, Int)] that returns a coordinate
-- square of size n, excluding the diagonal from (0,0) to (n,n).
squareNoDiagonal :: Int -> [(Int, Int)]
squareNoDiagonal n = [(x,y) | (x,y) <- grid n n, x /= y]


-- 4. In a similar way to the function length, show how the library function
-- replicate :: Int -> a -> [a] that produces a list of identical elements can
-- be defined using a list comprehension.
lengthEx :: [a] -> Int
lengthEx xs = sum [1 | _ <- xs]

replicateEx :: Int -> a -> [a]
replicateEx n x = [ x | _ <- [1..n] ]


-- 5. Using a list comprehension with 3 generators, define a function that returns the list of
-- all such triples whose components are at most a given limit.
pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]


-- 6. A positive integer is perfect if it equals the sum of all of its factors, excluding the number itself.
-- Using a list comprehension and the functions factors, define a function that 
-- returns the list of all perfect numbers up to a given limit.
perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (init (factorsEx x)) == x]
  where
    factorsEx n = [x | x <- [1..n], mod n x == 0]


-- 7. Show how the list comprehension [(x,y) | x <- [1,2], y <- [3,4]] with 2 generators can be
-- re-expressed using two comprehensions with single generators.
sol7 = concat [[(x,y) | y <- [3,4]] | x <- [1,2]] -- "2 dimensions"
sol7_2 = concat[ concat[ [ (x,y,z) | z <- [1,2] ] | y <- ['a','b']] | x <- ['@','#']] -- "3 dimensions"


-- 8. Redefine the function positions using the function find.

-- Return a list of all values mapped to a given key, 
-- from a list of key-value pairs.
findEx :: Eq a => a -> [(a,b)] -> [b]
findEx k t = [v | (k', v) <- t, k' == k]

-- Return a list of all positions at which a value occurs in a list, by 
-- pairing each element with its position, and selecting those positions at which
-- the desired value occurs.
positionsOfValInListEx :: Eq a => a -> [a] -> [Int]
positionsOfValInListEx x xs = findEx x (zip xs [0..])


-- 9. The scalar product of two lists is the sum of the products of the corresponding integers.
-- In a similar manner to chisqr, show how a list comprehension can be used to define a function
-- scalarproduct :: [Int] -> [Int] -> Int that returns the scalar product of two lists.

chisqrEx :: [Float] -> [Float] -> Float
chisqrEx os es = sum [((o - e)^2)/e | (o,e) <- zip os es]

scalarproduct xs ys = sum [ (x * y) | (x,y) <- zip xs ys]


-- 10. Modify the Caesar cipher program to also handle upper-case letters.

-- Return the integer between 0 and 57 corresponding to the letter and special character.
-- The special characters (located at positions 26 to 31) are: '[', '\', ']', '^', '_', '`' 
let2intEx :: Char -> Int
let2intEx c = ord c - ord 'A'

-- Return the character (including upper-case letters, and one of six special characters) 
-- corresponding to an integer between 0 and 57.
int2letEx :: Int -> Char
int2letEx n = chr (ord 'A' + n)

-- Return the character (letters and one of 6 specials) got after shifting a character,
-- by converting the character into the corresponding integer, adding on the shift factor and
-- taking the remainder when divided by 58, and converting the resulting
-- integer back into a character (letters and one of 6 specials).
-- Do not shift any other characters.
shiftEx :: Int -> Char -> Char
shiftEx n c
  | isLower c || isUpper c || c == '[' || c == '\\' || c == ']' || c == '^' || c == '_' || c == '`' 
    = int2letEx (mod (let2intEx c + n) 58)
  | otherwise = c

-- Return a string (containing both letters, lower- and upper-case, and the 6 special characters) which is encoded by
-- using the shift function and a shift factor.
encodeCaesarEx :: Int -> String -> String
encodeCaesarEx n xs = [shiftEx n x | x <- xs]




-- Chapter 6: Recursive functions --


-- 6.8 Exercises --


-- 1. How does the recursive version of the fac function behave if applied to a negative
-- argument such as (-1)? Modify the definition to prohibit negative arguments by adding a guard to
-- the recursive case.
facNegNo :: Int -> Int
facNegNo 0 = 1
facNegNo n | n > 0 = n * facNegNo (n-1)


-- 2. Define a recursive function sumdown :: Int -> Int that returns the sum of the non-negative
-- integers from a given value down to zero. 
sumdown :: Int -> Int
sumdown 0 = 0
sumdown n 
  | n < 0 = 0
  | n > 0 = n + sumdown (n-1)


-- 3. Define the exponentiation operator ^ for non-negative integers using the same pattern of
-- recursion as the multiplication operator *, and show how the expression 2 ^ 3 is evaluated 
-- using your definition.
mulHut2 :: Int -> Int -> Int
m `mulHut2` n | n <= 0 = 0
              | n > 0  = m + (m `mulHut2` (n-1))

expoHut :: Int -> Int -> Int
m `expoHut` n | n <= 0 = 1
              | n > 0  = m * (m `expoHut` (n-1))


-- 4. Define a recursive function euclid :: Int -> Int -> Int that implements Euclid's algorithm for
-- calculating the GCD of two non-negative integers: if the two numbers are equal, then this number
-- is the result; otherwise, the smaller number is subtracted from the larger, and the same process
-- is then repeated (with the smaller number and the difference).
euclid :: Int -> Int -> Int
euclid m n  | m <= 0, n <= 0  = 0
            | m == n          = m
            | m < n           = euclid m (n - m)
            | m > n           = euclid (m - n) n

-- Using the recursive functions defined in this chapter, show how length [1,2,3], drop 3 [1,2,3,4,5] and 
-- init 1,2,3]


-- 6. Without looking at the definitions from the standard prelude, define the following library
-- functions on lists using recursion.

-- a. Decide if all logical values in a list are True:
andHut :: [Bool] -> Bool
andHut []     = True -- Simple (base) case. Identity for && is True.
andHut (x:xs) = x && andHut xs 

-- b. Concatenate a list of lists
concatHut :: [[a]] -> [a]
concatHut []     = []
concatHut (x:xs) = x ++ concatHut xs
--concatHut (x:xs) = x : concatHut xs

-- c. Produce a list with n identical elements:
replicateHut :: Int -> a -> [a]
replicateHut 0 _ = []
replicateHut n x = x : replicateHut ((-) n 1) x 

-- d. Select the nth element of a list:
selectNth :: [a] -> Int -> a
selectNth (x:xs) 0 = x 
selectNth (x:xs) n | n > 0, n <= (length (x:xs)) = selectNth xs (n-1)

-- e. Decide if a value is an element of a list:
elemHut :: Eq a => a -> [a] -> Bool
elemHut _ []     = False
elemHut x (y:ys) | x == y = True 
                 | x /= y = False || elemHut x ys


-- 7. Define a recursive function merge :: Ord a => [a] -> [a] -> [a] that merges two sorted
-- lists to give a single sorted list.
-- Note: your definition should not use other functions on sorted lists, but should be defined
-- using explicit recursion.
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x <= y    = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys


-- 8. Using merge, define a function sortMerge :: Ord a => [a] -> [a] that implements merge sort,
-- in which the empty list and singleton lists are already sorted, and any other list is sorted by
-- merging together the two lists that result from sorting the two halves of the list separately.
-- Hint: first define the function halve :: [a] -> ([a],[a]) that splits a list into two halves
-- whose lengths differ by at most one.
sortMerge :: Ord a => [a] -> [a]
sortMerge [] = [] 
sortMerge [x] = [x]
sortMerge xs = merge (sortMerge (fst (halve2 xs))) (sortMerge (snd (halve2 xs))) 

halve2 :: [a] -> ([a],[a])
halve2 xs = splitAt (div (length xs) 2) xs


-- 9. Using the five-step process, construct the library functions that:
-- a. calculate the sum of a list of numbers;
-- b. take a given number of elements from the start of a list;
-- c. select the last element of a non-empty list.

sumHut :: Num a => [a] -> a
sumHut []     = 0
sumHut (x:xs) = (+) x (sumHut xs) 

takeHut :: Int -> [a] -> [a]
takeHut 0 xs = []
takeHut _ [] = []
takeHut n (x:xs) | n < 0  = []
                 | n >= 0 = x : takeHut (n-1) xs 

lastHut :: [a] -> a
lastHut [x] = x
lastHut (x:xs) = lastHut xs


-- Chapter 7: Higher-order functions --

-- 7.9 Exercises --

-- 1. Show how the list comprehension [f x | x <- xs, p x] can be re-expressed using 
-- the higher-order functions map and filter.
filmap :: [a] -> (a -> Bool) -> (a -> b) -> [b]
filmap xs p f = map f (filter p xs)  


-- 2. Without looking at the definitions from the standard prelude, define the following 
-- higher-order library functions on lists.

-- a. Decide if all elements of a list satisfy a predicate:
allHut :: (a -> Bool) -> [a] -> Bool
allHut p [] = True
allHut p (x:xs) = p x && allHut p xs

allC :: (a -> Bool) -> [a] -> Bool
allC p = and.map p

-- b. Decide if any element of a list satisfies a predicate:
anyHut :: (a -> Bool) -> [a] -> Bool
anyHut p [] = False
anyHut p (x:xs) = p x || anyHut p xs

anyC :: (a -> Bool) -> [a] -> Bool
anyC p = or.map p

-- c. Select elements from a list while they satisfy a predicate.
takeWhileHut :: (a -> Bool) -> [a] -> [a]
takeWhileHut _ [] = []
takeWhileHut p (x:xs) | p x       = x : takeWhileHut p xs
                      | otherwise = []

-- d. Reject elements from a list while they satisfy a predicate.
dropWhileHut :: (a -> Bool) -> [a] -> [a]
dropWhileHut _ [] = []
dropWhileHut p (x:xs) | p x       = dropWhileHut p xs
                      | otherwise = x : xs


-- 3. Redifine the functions map f and filter p using foldr.
mapFr, mapFr2, mapR :: (a -> b) -> [a] -> [b]

mapFr f = foldr ((:) . f) []

mapFr2 f = foldr (\x -> \xs -> f x : xs) []

mapR _ [] = []
mapR f (x:xs) = f x : mapR f xs 

filterFr :: (a -> Bool) -> [a] -> [a]
filterFr p = foldr (\x xs -> if p x then x : xs else xs) []  

filterR :: (a -> Bool) -> [a] -> [a]
filterR _ [] = []
filterR p (x:xs) | p x       = x : filterR p xs
                 | otherwise = filterR p xs


-- 4. Using foldl, define a function dec2int :: [Int] -> Int that converts
-- a decimal number into an integer. E.g. dec2int [2,3,4,5] = 2345

-----------------------------------------------------------------------------

-- f v []     = v
-- f v (x:xs) = f (v # x) xs

-- foldl (#) v [x0, x1, ... , xn] = (... ((v # x0) # x1) ...) # xn

-----------------------------------------------------------------------------

dec2int :: [Int] -> Int
dec2int = foldl (\v -> \x -> 10*v + x) 0


-- 5. Without looking at the definitions in the standard prelude, define the 
-- higher-order library function curry that converts a function on pairs to 
-- a curried function, and conversely
-- the function uncurry that converts a curried function with two arguments into 
-- a function on pairs.
-- Hint: first write down the types of the two functions.

curryHut :: ((a,b) -> c) -> a -> b -> c
curryHut f = \x -> \y -> f (x,y)

uncurryHut :: (a -> b -> c) -> (a,b) -> c
uncurryHut f = \(x,y) -> f x y


-- 6. A higher-order function unfold that encapsulates a simple pattern of
-- recursion for producing a list can be defined as follows:
unfoldHut p h t x | p x       = []
                  | otherwise = h x : unfoldHut p h t (t x)
-- Redefine the functions chop8, map f and iterate f using unfold.

-- Convert an integer to list of bits 0 or 1.
int2binUnf :: Int ->[Bit]
int2binUnf = unfoldHut (== 0) (`mod` 2) (`div` 2)

--             chop8 :: [Bit] -> [[Bit]]
--             chop8 []   = []
--             chop8 bits = take 8 bits : chop8 (drop 8 bits) 

chop8Unf :: [Bit] -> [[Bit]]
chop8Unf = unfoldHut (== []) (take 8) (drop 8) 

mapUnf :: Eq a => (a -> b) -> [a] -> [b]
mapUnf f = unfoldHut (== []) (f . head ) (tail )

iterateHut :: (Int -> Int) -> Int -> [Int]
iterateHut f n | n > 144  = []
               | otherwise = n : iterateHut f (f n)

iterateUnf :: (Int -> Int) -> Int -> [Int]
iterateUnf f = unfoldHut (> 144) id f

-- Iterate while True
iterateUnfBTrue :: (Bool -> Bool) -> Bool -> [Bool]
iterateUnfBTrue f = unfoldHut (== False) id f

-- Iterate while False
iterateUnfBFalse :: (Bool -> Bool) -> Bool -> [Bool]
iterateUnfBFalse f = unfoldHut (== True) id f


-- 7. Modify the binary string transmitter example to detect simple transmission 
-- errors using the concept of parity bits. That is, each 8-bit binary number
-- produced during encoding is extended with a parity bit. The parity bit is set 
-- to 1 if the number contains an odd number of ones, and to 0 otherwise. 
-- In turn, each resulting 9-bit number consumed during decoding is checked to 
-- ensure that its parity bit is correct. If the parity bit is correct it is 
-- discarded, otherwise a parity error is reported.
--
-- Hint: the library function error :: String -> a displays the given string as
-- an error message and terminates the program; the polymorphic result type 
-- ensures that error can be used in any context.
parify :: [Int] -> [Int]
parify [] = []
parify xs | even (sum xs) = xs ++ [0]
          | otherwise     = xs ++ [1]

unparify :: [Int] -> [Int]
unparify [] = []
unparify xs | even (sum (init xs)) && (last xs == 0) = init xs
            | odd (sum (init xs)) && (last xs == 1)  = init xs
            | otherwise                              = error "Parity error!"


-- 8. Test your new string transmitter program from the previous exercise using
-- a faulty communication channel that forgets the first bit, which can be 
-- modelled using the tail function on lists of bits.
transmitParity :: String -> String
transmitParity = decode . unparify . channelParity . parify . encode
             where
               channelParity :: [Bit] -> [Bit]
               channelParity = tail


-- 9. Define a function thta applies its 2 argument functions to successive
-- elements in a list alternately, in turn about order.
-- For example:
-- altMap (+10) (+100) [0,1,2,3,4]
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ [] = []
altMap f _ (x0:[]) = f x0 : []
altMap f g (x0:x1:[]) = f x0 : g x1 : []
altMap f g (x0:x1:xs) = f x0 : g x1 : altMap f g xs


-- 10. Using altMap, define a function luhn that implements the Luhn algorithm from
-- the exercises in chapter 4 for bank card numbers of any length. 
-- Test your new function using your own bank card.

{- 
-- 8. The Luhn algorithm is used to check bank card numbers from simple errors such as
-- mistyping a digit, and proceeds as follows:
-- . consider each digit as a seperate number;
-- . moving left, double every other number from the second last;
-- . subtract 9 from each number that is now greater than 9;
-- . add all the resulting numbers together;
-- . if the total is divisible by 10, the card number is valid.
--
-- Define a function luhnDouble::Int->Int that doubles a digit and subtracts 9 
-- if the result is greater than 9.
-- Using luhnDouble and `mod`, define a function luhn that decides if a four-digit bank 
-- card number is valid.

luhn :: Int -> Int -> Int -> Int -> Bool
luhn i j k l 
  | mod (luhnDouble i + j + luhnDouble k + l) 10 == 0 = True
  | otherwise = False


luhnDouble :: Int -> Int
luhnDouble n 
    | n*2 < 9   = n*2
    | otherwise = (n*2 - 9)
-}

luhn2 :: [Int] -> Bool
luhn2 ns | mod ((sum . altMap id luhnDouble . reverse) ns) 10 == 0 = True
         | otherwise = False



-- 8.9 Exercises --

{-

1. In a similar manner to the function add, define a recursive multiplication
   function for the recursive type of natural numbers. 
   Hint: make use of addNats in your definition.

addNatsR :: Nat -> Nat -> Nat
addNatsR Zero n     = n
addNatsR (Succ m) n = Succ (addNatsR m n) 

-}

multNat :: Nat -> Nat -> Nat
multNat m n = int2nat (nat2int m * nat2int n)

multNatsR            :: Nat -> Nat -> Nat
multNatsR Zero n     = Zero
multNatsR n Zero     = Zero
multNatsR (Succ m) n = addNatsR n (multNatsR m n) 


{-

2. Using the function compare :: Ord a => a -> a -> Ordering define the function
   occurs :: Ord a => a -> Tree a -> Bool for search trees. 
   Why is this new definition more efficient than the original version?

occursTSearch                          :: (Ord a) => a -> Tree a -> Bool
occursTSearch x (Leaf y)               =  x == y
occursTSearch x (Node l y r) | x == y  =  True
                             | x < y   =  occursTSearch x l
                             | x > y   =  occursTSearch x r

-}

occursTSearchOrd                :: (Ord a) => a -> Tree a -> Bool
occursTSearchOrd x (Leaf y)     =  compare x y == EQ
occursTSearchOrd x (Node l y r) =
  case compare x y of
    EQ -> True
    LT -> occursTSearchOrd x l
    GT -> occursTSearchOrd x r

{-

3. Consider the following type of binary trees:
   data Tree a = Leaf a | Node (Tree a) (Tree a)
   Let us say that such a tree is 'balanced' if the number of leaves in the left
   and right subtree of every node differs by at most one, with leaves themselves
   being trivially balanced.
   Define a function balanced :: Tree a -> Bool that decides whether a tree is
   balanced or not.
  Hint: first define a function that returns the number of leaves in a tree.

-}

-- Depicts a tree data structure which is balanced.
data TreeBal a = LeafBal a | NodeBal (TreeBal a) (TreeBal a) deriving Show

tBal :: TreeBal Int
tBal = NodeBal  (NodeBal (LeafBal 1) (LeafBal 4)) 
                (NodeBal (LeafBal 6) (LeafBal 9)) 

tBal2 :: TreeBal Int
tBal2 = NodeBal 
            (NodeBal 
                (LeafBal 4) 
                (NodeBal 
                    (LeafBal 13) 
                    (LeafBal 0)))
            (NodeBal 
                (NodeBal 
                    (LeafBal 333) 
                    (NodeBal 
                        (LeafBal 6) 
                        (LeafBal 9)))
                (LeafBal 42))


isBalanced                                 :: TreeBal Int -> Bool
isBalanced (LeafBal _)                     =  True
isBalanced (NodeBal l r) = (diffLeaves <= 1) && isBalanced l && isBalanced r
  
  where

    diffLeaves = abs (numLeaves l - numLeaves r)

    numLeaves               :: TreeBal Int -> Int
    numLeaves (LeafBal _)   =  1
    numLeaves (NodeBal l r) =  numLeaves l + numLeaves r

{- 
 
4. Define a function balance :: [a] -> Tree a that converts a non-empty list into
   a balanced tree.
   Hint: first define a function that splits a list into two halves whose length 
   differs by at most one.

   -- Depicts a tree data structure which is balanced.
   data TreeBal a = LeafBal a | NodeBal (TreeBal a) (TreeBal a) deriving Show

  flatten :: Tree a -> [a]
  flatten (Leaf x) = [x]
  flatten (Node l x r) = flatten l ++ [x] ++ flatten r

-}

balance     :: [a] -> TreeBal a
balance []  =  error "Provide a list that is non-empty!"
balance [x] =  LeafBal x
balance xs  =  NodeBal (balance (fst (halveList xs))) (balance (snd (halveList xs)))  

halveList :: [a] -> ([a],[a])
halveList [] = ([],[])
halveList xs = splitAt (half xs) xs
  where
    half :: [a] -> Int
    half xs = div (length xs) 2 


{-

5. Given the type declaration
   data Expr = Val Int | Add Expr Expr
   Define the higher-order function
   folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
   such that folde f g replaces each Val constructor in an expression by the 
   function f, and each Add constructor by the function g.

-}

folde                 :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f g (Val n)     =  f n
folde f g (Add e1 e2) =  g (folde f g e1) (folde f g e2)


{-
6. Using folde define a funciton
   eval :: Expr -> Int
   that evaluates an expression to an integer value, and a function 
   size :: Expr -> Int
   that calculates the number of values in an expression.
-}

evalE             :: Expr -> Int
evalE (Val n)     =  n
evalE (Add e1 e2) =  folde toEnum (+) (Add e1 e2)

numVals             :: Expr -> Int
numVals (Val n)     =  1
numVals (Add e1 e2) =  numVals e1 + numVals e2  


{-

7. Complete the following instance declarations:
     instance Eq a => Eq (Maybe a) where
     instance Eq a => Eq [a] where

instance Eq a => Eq (Maybe a) where
  -- Defines the (==) operation.
  Nothing == Nothing = True
  Just    == Just    = True
  _       == _       = False

instance Eq a => Eq [a] where
  -- Defines the (==) operation.
  [] == []         = True
  [x] == [y]       = x == y
  (x:xs) == (y:ys) = x==y && xs==ys
  _  == _          = False 

-}


{-

8. Extend the tautology checker to support the use of logical disjunction (V) and
   equivalence (<=>) in propositions.

   Truth Table for Disjunction (OR operation).

    A | B | A v B
   ---------------
    F | F |   F
    F | T |   T
    T | F |   T
    T | T |   T


    Truth Table for Equivalence.

    A | B | A <=> B
   -----------------
    F | F |    T
    F | T |    F
    T | F |    F
    T | T |    F
-}

data Prp =
    Constantification Bool
  | Assignment Char
  | Negation Prp
  | Equivalence Prp Prp
  | Disjunction Prp Prp
  | Conjunction Prp Prp
  | Implication Prp Prp

-- A list of pairs of keys to their corresponding values. 
type Matches key value = [(key,value)]

-- Substitution of values of type Bool for keys of type Char. 
-- E.g. the substitution [('A',False), ('B', True)] substitutes the value
-- False for A and the value True for B.
type Substitution = Matches Char Bool


-- Evaluates a proposition in terms of Substitution for its variables.
evalPrp :: Substitution -> Prp -> Bool
evalPrp _ (Constantification b)  =  b
evalPrp s (Equivalence p1 p2)    =  not (evalPrp s p1 || evalPrp s p2)
evalPrp s (Assignment c)         =  findInTable c s -- Look up the list of Substitution, and substitute the Bool value for the Char argument.
evalPrp s (Negation p)           =  not (evalPrp s p)
evalPrp s (Disjunction p1 p2)    =  evalPrp s p1 || evalPrp s p2
evalPrp s (Conjunction p1 p2)    =  evalPrp s p1 && evalPrp s p2
evalPrp s (Implication p1 p2)    =  evalPrp s p1 <= evalPrp s p2  -- Knowing that: False < True

-- Returns all the variables in a proposition.
variables :: Prp -> [Char]
variables (Constantification _)  =  [] 
variables (Assignment c)        =  [c]
variables (Equivalence p1 p2)   =  variables p1 ++ variables p2
variables (Negation p)          =  variables p
variables (Disjunction p1 p2)   =  variables p1 ++ variables p2
variables (Conjunction p1 p2)   =  variables p1 ++ variables p2
variables (Implication p1 p2)   =  variables p1 ++ variables p2

-- Returns all the possible boolean values.
boolsAll :: Int -> [[Bool]]
boolsAll 0  =  [[]]
boolsAll n  =  map (False :) bss ++ map (True :) bss
                 where
                   bss = boolsAll (n-1)

-- Generates all the possible substitutions for a given proposition.
substitutions :: Prp -> [Substitution]
substitutions p  =  map (zip vs) (boolsAll (length vs))
                    where
                      vs = rmdups $ variables p

-- Decides whether a proposition is a tautology (a logical statement which is always true).
isItATautology :: Prp -> Bool
isItATautology p  =  and [evalPrp s p | s <- substitutions p]



{- 

  9. Extend the abstract machine to support the use of multiplication.

-}

-- Declarations -----------------------------------------------------

data Exp =
    Constantization Int
  | Addition Exp Exp
  | Multiplication Exp Exp
  deriving Show

data Oper = 
    EVALUATE Exp
  | AD Int
  | MU Int

type Controls = [Oper]

---------------------------------------------------------------


-- Definitions

-- Evaluates an expression in the context of a control stack.
evalExp                           :: Exp -> Controls -> Int
evalExp (Constantization n) c     =  execOper c n
evalExp (Addition e1 e2) c        =  evalExp e1 (EVALUATE e2 : AD 0 : c)
evalExp (Multiplication e1 e2) c  =  evalExp e1 (EVALUATE e2 : MU 1 : c)


-- Executes the control stack in the context of an integer operand.
execOper                             :: Controls -> Int -> Int
execOper [] n                        =  n
execOper (EVALUATE e1 : AD 0 : c) n  =  evalExp e1 (AD n : c)
execOper (EVALUATE e1 : MU 1 : c) n  =  evalExp e1 (MU n : c)
execOper (AD n : c) m                =  execOper c (n+m)
execOper (MU n : c) m                =  execOper c (n*m)


-- Calculates the value of an expression using a control stack.
valExp    :: Exp -> Int
valExp e  =  evalExp e []

--

-- Values

exp0 = Constantization 0

exp1 = Constantization 1

exp2 = Addition exp0 exp1

exp3 = Multiplication (Constantization 5) (Constantization 5)

exp4 = Addition exp0 exp2

exp5 =
  Addition
    (Multiplication exp0 exp1)
    (Multiplication exp1 exp2)



-- Chapter 9: The Countdown Problem --


-- 9.11 Exercises --


{-  
1. Redefine the combinatorial function choices using a list comprehension rather
   than using composition, concat and map.
-}
  
-- Returns all possible ways of selecting zero or more elements in any order.
--choiceslc                 ∷   [a] → [[a]]
--choiceslc                 =   concat . map perms . subs

--data Ope =
--    Addi
--  | Subs
--  | Mult
--  | Divi
--
--instance Show Ope where
--  show Addi = "+"
--  show Subs = "-"
--  show Mult = "*"
--  show Divi = "/"
--
---- Decides whether applying an operator to two positive naturals gives another positive natural.
--valid :: Ope -> Int -> Int -> Bool
--valid Addi x y = x <= y
--valid Subs x y = x > y
--valid Mult x y = x <= y && x /= 1 && y /= 1
--valid Divi x y = x `mod` y == 0 && y /= 1
--
---- Performs a valid application
--apply :: Ope -> Int -> Int -> Int
--apply Addi x y = x + y
--apply Subs x y = x - y
--apply Mult x y = x * y
--apply Divi x y = x `div` y
--
--
---- 9.3 Numeric expressions --
--
--data Expre = Valu Int | Appl Ope Expre Expre
--
--instance Show Expre where
--  show (Valu n)          =  show n
--  show (Appl o l r)      =  addParens l ++ show o ++ addParens r
--                            where
--                               addParens (Valu n) = show n
--                               addParens e        = "(" ++ show e ++ ")"
--
---- Gives all the values in an expression
--values                   ∷  Expre → [Int]
--values (Valu n)          =  [n]
--values (Appl _ l r)      =  values l ++ values r
--
--
---- Evaluates the whole expression
--evalu                    ∷  Expre → [Int]
--evalu (Valu n)           =  [n | n > 0]
--evalu (Appl o l r)       =  [apply o x y
--                                | x ← evalu l
--                                , y ← evalu r
--                                , valid o x y]
--
---- 9.4 Combinatorial functions --
--
---- Gives subsequences list of all.
--subs                     ∷  [a] → [[a]]
--subs []                  =  [[]]
--subs (x:xs)              =  yss ++ map (x:) yss
--                              where yss = subs xs
--                                    
---- Provides ways possible all of inserting a new element into a list.
--interleave               ∷  a → [a] → [[a]]
--interleave x []          =  [[x]]
--interleave x (y:ys)      =  (x:y:ys) : map (y:) (interleave x ys)
--
---- Returns all permutations of a list.
--perms                    ∷  [a] → [[a]]
--perms []                 =  [[]]
--perms (x:xs)             =  concat (map (interleave x) (perms xs))
--
---- Returns all possible ways of selecting zero or more elements in any order.
--choices                  ∷   [a] → [[a]]
--choices                  =   concat . map perms . subs
--
---- Decides whether a list of numbers has a solution to the given expression.
---- Returns true if given an expression, a list of numbers and a target, if the list of
---- values in the expression is chosen from the list of numbers, and the
---- expression evaluates to give the target.
--hasSolution              ∷   Expre → [Int] → Int → Bool
--hasSolution e ns n       =  elem (values e) (choices ns) && evalu e == [n]
--
--
---- 9.6 Brute force --
--
---- Splits a list into two non-empty lists in all possible ways.
--splitup         ∷   [a] → [([a],[a])]
--splitup []      =   []
--splitup [_]     =   []
--splitup (x:xs)  =   ([x], xs) : [(x:ls, rs) | (ls, rs) ← splitup xs]
--
---- Takes a list of integers and generates all the possible expressions whose list
---- of values is presicely the given list.
--exprs       ∷  [Int] → [Expre] 
--exprs []    =  []
--exprs [n]   =  [Valu n] 
--exprs ns    =  [e |  (ls, rs) ← splitup ns, l ← exprs ls, r ← exprs rs, e ← joinexprs l r]
--
---- Takes two expressions and combines them in all possible ways using each of the four
---- numeric operators.
--joinexprs      ∷  Expre → Expre → [Expre]
--joinexprs l r  =   [Appl o l r | o ← opes]
--
---- The four numeric operators
--opes  ∷  [Ope]
--opes  =  [Addi, Subs, Mult, Divi]   
--
--
---- solutions: Takes a list of numbers and a target number, and generates all possible
---- expressions over each choice from the list of numbers which evaluate to give the target
---- number successfully.
--solutions        ∷   [Int] → Int → [Expre]
--solutions ns n   =   [e | ns' ← choices ns, e ← exprs ns', evalu e == [n]]
--
--
---- 9.8 Combining generation and evaluation --
--
---- A pair comprising an expression and the evaluation of that expression. 
--type Result = (Expre, Int)
--
---- Takes a list of integers and generates all possible pairings of an expression formed using the
---- integers from the list and the evaluation of that expression.
--results ∷ [Int] → [Result]
--results []    =   []
--results [n]   =   [(Valu n, n) | n > 0]
--results ns    =   [res | (ls, rs) ← splitup ns, lx ← results ls, ry ← results rs, res ← combine' lx ry]
--
--combine' ∷ Result → Result → [Result]
--combine' (l,x) (r,y) = [(Appl o l r, apply o x y) | o ← opes, valid o x y]
--
---- Takes a list of integers and a single integer (the target), and finds all the expressions
---- (by choosing various combinations of the integers) that evaluate to the target.
--solutions' ∷ [Int] → Int → [Expre]
--solutions' ns n   =    [e | ns' ← choices ns, (e,n') ← results ns', n' == n] 
--
--
--
--
--
--
--
--
--
--
--
--
--
--
