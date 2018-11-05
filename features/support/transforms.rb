ParameterType(
  name:        'model_name',
  regexp:      /\w+/,
  type:        String,
  transformer: ->(s) { s.classify }
)

