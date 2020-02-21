let Color = require('color')
let colors = {}
let gradients = {}

body = Color('hsl(198, 38%, 18%)')
body_darker = Color('hsl(198, 46%, 15%)')
item = Color('hsl(198, 62%, 10%)')
colors['body']         = body.string()
colors['body-darker']  = body_darker.string()
colors['body-darker-0'] = body_darker.alpha(0).string()
colors['item']         = item.string()
colors['item-50']      = item.alpha(.5).string()
colors['item-darker']  = 'hsl(202, 38%, 6%)'
colors['item-gray']    = 'hsl(198, 16%, 19%)'

gradients['published'] = "hsl(202,47%,14%) linear-gradient(to bottom right, hsl(202,90%,20%) 0%, hsla(202,36%,20%,.2) 50%, hsla(202,90%,20%,0) 100%)"

// gradients['anons-grad'] = `linear-gradient(to right, ${body.alpha(.8)} 0%, ${body.alpha(0)} 500px)`

// WHITE

let white = Color('hsl(200, 2%, 90%)')
colors['white'] = white.string()
colors['white-hover'] = white.lightness(100).string()
colors['white-80'] = white.alpha(0.80).string()
colors['white-50'] = white.alpha(0.50).string()
colors['white-20'] = white.alpha(0.20).string()
colors['white-10'] = white.alpha(0.10).string()
colors['white-05'] = white.alpha(0.05).string()
colors['white-03'] = white.alpha(0.03).string()
colors['white-on-black'] = 'hsl(200, 7%, 85%)'

// RED

let red = Color('hsl(8, 83%, 49%)')
let orange = Color('hsl(18, 83%, 61%)')
colors['red'] = red.string()
colors['red-hover'] = red.lighten(.1).string()
colors['orange'] = orange.string()
colors['orange-hover'] = orange.lighten(.1).string()

gradients['red-grad-x'] = `linear-gradient(to right, ${orange}, ${red})`
gradients['red-grad-y'] = `linear-gradient(${red}, ${orange})`
gradients['red-grad-x-hover'] = `linear-gradient(to right, ${orange.lighten(.1)}, ${red.lighten(.1)})`
gradients['red-grad-y-hover'] = `linear-gradient(, ${red.lighten(.1)}, ${orange.lighten(.1)})`

// BLUE

let blue = Color('hsl(198, 51%, 50%)')
let light_blue = Color('hsl(196, 28%, 62%)')
colors['blue'] = blue.string()
colors['blue-50'] = blue.alpha(0.50).string()
colors['blue-20'] = blue.alpha(0.20).string()
colors['blue-10'] = blue.alpha(0.10).string()
colors['blue-05'] = blue.alpha(0.05).string()
colors['light-blue'] = light_blue.string()
colors['light-blue-hover'] = light_blue.lighten(.1).string()

gradients['blue-mark-grad'] = 'linear-gradient(120deg, #0081ce 0%, rgba(0, 115, 184, .680985) 2.68%, rgba(0, 102, 162, .376874) 7.07%, rgba(0, 85, 136, 0) 28.7%), linear-gradient(90deg, rgba(0, 77, 124, .25) 0%, rgba(0, 45, 71, 0) 100%)'

// GREEN

let lime = Color('hsl(76, 78%, 45%)')
let green = Color('hsl(96, 66%, 38%)')
colors['lime'] = lime.string()
colors['green'] = green.string()

gradients['green-grad-x'] = `linear-gradient(to right, ${lime}, ${green})`
gradients['green-grad-y'] = `linear-gradient(${lime}, ${green})`

module.exports = { colors, gradients }
