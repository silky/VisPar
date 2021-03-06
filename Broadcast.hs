module Main where
import VisPar 
import Control.DeepSeq

example :: Par Int
example = do
  one   <- new
  two   <- new
  three <- new
  fork $ do
    x <- get one
    put two (x + 1)
  fork $ do
    x <- get one
    put three (x + 2)
  put one 1
  (+) <$> get two <*> get three

main :: IO ()
main = do
  print $ runPar example
  saveGraphPdf True "broadcast.graph.pdf" $ makeGraph True Nothing example
