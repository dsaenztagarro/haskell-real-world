### Functors

```
fmap id  ==  id
fmap (f . g)  ==  fmap f . fmap g
```

- Functors must preserve identity. Applying `fmap id` to a value should give us
  back an identical value.

- Functors must be composable. Composing two uses of fmap should give the same 
  result as one fmap with the same functions composed

`(<$>)` is an alias for `fmap` present in `Control.Applicative` module

### Monoids

```
class Monoid a where
    mempty :: a             -- the identity
    mappend :: a -> a -> a  -- associative binary operator
```

### Writer Monad

The values we write can be of any Monoid type.

The `Writer` monad uses the Monoid's `mappend` function every time we use `tell`

## Applicative Functors

Anytime you feel the need to define different higher order functions to 
accommodate a different number of arguments, think about how defining a proper 
instance of Applicative can make your life easier.

```haskell
class (Functor f) => Applicative f where
    pure  :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b
```

```haskell
pure id <*> v = v                            -- Identity
pure (.) <*> u <*> v <*> w = u <*> (v <*> w) -- Composition
pure f <*> pure x = pure (f x)               -- Homomorphism
u <*> pure y = pure ($ y) <*> u              -- Interchange
```

Functor instance:

```haskell
fmap f x = pure f <*> x                      -- Fmap
```

## Applicative Monads

## MonadPlus

```haskell
-- mzero is a neutral element
mzero `mplus` m  =  m
m `mplus` mzero  =  m
-- mplus is associative
-- (but not all instances obey this law because it makes some infinite structures impossible)
m `mplus` (n `mplus` o)  =  (m `mplus` n) `mplus` o

mzero >>= f  =  mzero
m >> mzero   =  mzero

(m `mplus` n) >>= k  =  (m >>= k) `mplus` (n >>= k)
```

Useful functions: `msum`, `guard`

More info: [click](http://en.wikibooks.org/wiki/Haskell/MonadPlus)

