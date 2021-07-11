{ name = "uint"
, dependencies =
  [ "prelude"
  , "math"
  , "maybe"
  , "psci-support"
  , "enums"
  , "gen"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/purescript-contrib/purescript-uint.git"
}
