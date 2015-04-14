### Functors

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

