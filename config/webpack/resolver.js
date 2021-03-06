const path = require('path')

module.exports = {
  resolve: {
    alias: {
      node_modules: path.resolve(__dirname, '../../node_modules'),
      backend:      path.resolve(__dirname, '../../app/javascript/backend'),
      css:          path.resolve(__dirname, '../../app/javascript/css'),
      utils:        path.resolve(__dirname, '../../app/javascript/utils'),
      components:   path.resolve(__dirname, '../../app/javascript/components'),
      pages:        path.resolve(__dirname, '../../app/javascript/pages'),
    }
  }
}
