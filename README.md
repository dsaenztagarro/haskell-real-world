# Haskell Real World

All exercises have been modified in order to run with Haskell 2014

```shell
$ cabal install QuickCheck-1.2.0.1
$ ghc-pkg expose QuickCheck-1.2.0.1
$ ghc-pkg hide QuickCheck-2.7.*
$ ghc-pkg list | grep QuickCheck
```

Running tests

```shell
ghc --make Run.hs
./Run
```
