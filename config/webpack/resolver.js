const path = require('path')

module.exports = {
  resolve: {
    alias: {
      node_modules: path.resolve(__dirname, '../../node_modules'),
      css: path.resolve(__dirname, '../../app/javascript/css'),
      profile: path.resolve(__dirname, '../../app/javascript/profile'),
      utils: path.resolve(__dirname, '../../app/javascript/utils'),
      components: path.resolve(__dirname, '../../app/javascript/components'),
      pages: path.resolve(__dirname, '../../app/javascript/pages'),
    }
  }
}
