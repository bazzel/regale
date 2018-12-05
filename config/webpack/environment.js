const { environment } = require('@rails/webpacker')
const erb =  require('./loaders/erb')
const patternflyConfig = require('./patternfly')

environment.config.merge(patternflyConfig);

environment.loaders.append('erb', erb)
module.exports = environment
