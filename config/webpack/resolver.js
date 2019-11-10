const path = require('path')

module.exports = {
  resolve: {
    alias: {
      profile: path.resolve(__dirname, '../../app/javascript/profile'),
      utils: path.resolve(__dirname, '../../app/javascript/utils'),
    }
  }
}
