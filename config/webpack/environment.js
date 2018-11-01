const { environment } = require('@rails/webpacker')
const webpack          = require('webpack')
const patternflyConfig = require('./patternfly')

environment.config.merge(patternflyConfig);

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery'
  })
)

module.exports = environment
