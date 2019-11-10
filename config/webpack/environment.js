const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const pugConfig = require('./loaders/pug')
const resolver = require('./resolver.js')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.config.merge(pugConfig);
environment.config.merge(resolver);
module.exports = environment
