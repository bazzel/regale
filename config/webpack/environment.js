const { environment } = require('@rails/webpacker')
const patternflyConfig = require('./patternfly')

environment.config.merge(patternflyConfig);

module.exports = environment
