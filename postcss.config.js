module.exports = {
  syntax: 'postcss-scss',
  plugins: [
    require('postcss-import'),
    // require('postcss-flexbugs-fixes'),
    // require('precss'),
    require('tailwindcss')('./app/javascript/css/tailwind/tailwind.js'),
    // require('autoprefixer'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
