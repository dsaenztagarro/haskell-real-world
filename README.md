# Haskell Real World

All exercises have been modified in order to run with Haskell 2014

### Packages globally installed

```shell
-- QuickCheck version for exercise
cabal install QuickCheck-1.2.0.1
ghc-pkg expose QuickCheck-1.2.0.1
ghc-pkg hide QuickCheck-2.7.*
ghc-pkg list | grep QuickCheck

-- Adds System.Random package
cabal install random

-- Monad transformers (Required for State monad, ...)
cabal install mtl
```

### Examples

```haskell
-- ch14/Random.hs
twoBadRandoms `fmap` getStdGen
```

### Running tests

```shell
ghc --make Run.hs
./Run

# Test coverage
ghc -fhpc Run.hs --make
./Run
hpc report Run --exclude=Main --exclude=QC
hpc markup Run --exclude=Main --exclude=QC

# Adding tests
ghc -fhpc Run.hs --make -no-recomp
```
