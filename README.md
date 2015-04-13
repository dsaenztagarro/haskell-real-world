# Haskell Real World

All exercises have been modified in order to run with GHC 7.8.4

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

-- ch15/Supply.hs
runSupply next [1,2,3]
runSupply (liftM2 (,) next next) [1,2,3]

-- ch15/RandomSupply.hs
(fst . runSupply next) `fmap` randomsIO

-- ch15/SupplyInstance.hs
runReader (ask >>= \x -> return (x * 3)) 2
(fst . runSupply xy) `fmap` randomsIO
runMS xy 2
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

### Review

- [ ] ‘Supply’ is an instance of Monad but not Applicative - this will become 
      an error in GHC 7.10, under the Applicative-Monad Proposal.
