let conf = ./spago.dhall
in conf // {
, dependencies = conf.dependencies #
  [ "effect"
  , "newtype"
  , "quickcheck"
  , "quickcheck-laws"
  ]
, sources = conf.sources # [ "test/**/*.purs" ]
}
