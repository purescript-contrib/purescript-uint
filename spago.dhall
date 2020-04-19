{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "uint"
, dependencies =
  [ "console"
  , "effect"
  , "generics-rep"
  , "math"
  , "maybe"
  , "psci-support"
  , "quickcheck"
  , "quickcheck-laws"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/zaquest/purescript-uint.git"
}
