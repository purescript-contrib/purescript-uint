{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "uint"
, dependencies =
  [ "prelude"
  , "effect"
  , "math"
  , "maybe"
  , "psci-support"
  , "quickcheck"
  , "quickcheck-laws"
  , "enums"
  , "gen"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/purescript-contrib/purescript-uint.git"
}
