[![Test](https://github.com/zaquest/purescript-uint/workflows/Test/badge.svg?branch=master)](https://github.com/zaquest/purescript-uint/actions)
[![Pursuit](http://pursuit.purescript.org/packages/purescript-uint/badge)](http://pursuit.purescript.org/packages/purescript-uint/)

This module provides 32-bit unsigned integers. Provided type `UInt`
is based on the `x >>> 0` trick analogous to how PureScript's `Int`
is based on `x | 0` trick.
The type has range from `0` to `4294967295`.
