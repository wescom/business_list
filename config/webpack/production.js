#process.env.NODE_ENV = process.env.NODE_ENV || 'production'

#const environment = require('./environment')

#module.exports = environment.toWebpackConfig()


const { environment } = require('@rails/webpacker')
var webpack = require('webpack');
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
  })
)
module.exports = environment