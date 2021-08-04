# uint

[![CI](https://github.com/purescript-contrib/purescript-uint/workflows/CI/badge.svg?branch=main)](https://github.com/purescript-contrib/purescript-uint/actions?query=workflow%3ACI+branch%3Amain)
[![Release](https://img.shields.io/github/release/purescript-contrib/purescript-uint.svg)](https://github.com/purescript-contrib/purescript-uint/releases)
[![Pursuit](https://pursuit.purescript.org/packages/purescript-uint/badge)](https://pursuit.purescript.org/packages/purescript-uint)
[![Maintainer: zaquest](https://img.shields.io/badge/maintainer-zaquest-teal.svg)](https://github.com/zaquest)
[![Maintainer: jamesdbrock](https://img.shields.io/badge/maintainer-jamesdbrock-teal.svg)](https://github.com/jamesdbrock)

Provides the 32-bit unsigned integer type `UInt`, and operations.

The `UInt` operations are
based on the JavaScript `x >>> 0` trick, analogous to how
PureScript’s `Int` is based on the JavaScript `x | 0` trick.

* [MDN — operator unsigned right shift](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Unsigned_right_shift)
* [Stack Overflow — the JavaScript `x >>> 0` trick](https://stackoverflow.com/questions/1822350/what-is-the-javascript-operator-and-how-do-you-use-it)

## Installation

Install `uint` with [Spago](https://github.com/purescript/spago):

```sh
spago install uint
```

## Documentation

`uint` documentation is stored in a few places:

1. Module documentation is [published on Pursuit](https://pursuit.purescript.org/packages/purescript-uint).
2. Written documentation is kept in the [docs directory](./docs).
3. Usage examples can be found in [the test suite](./test).

If you get stuck, there are several ways to get help:

- [Open an issue](https://github.com/purescript-contrib/purescript-uint/issues) if you have encountered a bug or problem.
- Ask general questions on the [PureScript Discourse](https://discourse.purescript.org) forum or the [PureScript Discord](https://purescript.org/chat) chat.

## Contributing

You can contribute to `uint` in several ways:

1. If you encounter a problem or have a question, please [open an issue](https://github.com/purescript-contrib/purescript-uint/issues). We'll do our best to work with you to resolve or answer it.

2. If you would like to contribute code, tests, or documentation, please [read the contributor guide](./CONTRIBUTING.md). It's a short, helpful introduction to contributing to this library, including development instructions.

3. If you have written a library, tutorial, guide, or other resource based on this package, please share it on the [PureScript Discourse](https://discourse.purescript.org)! Writing libraries and learning resources are a great way to help this library succeed.

## Development

Run the tests with

```sh
spago -x test.dhall test
```
