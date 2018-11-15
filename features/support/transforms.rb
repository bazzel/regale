ParameterType(
  name:        'model_name',
  regexp:      /\w+/,
  type:        String,
  transformer: ->(s) { s.classify }
)


ParameterType(
  name: 'event',
  regexp: /event "([^"]+)"/,
  type: Event,
  transformer: ->(title) { Event.find_by(title: title) }
)
