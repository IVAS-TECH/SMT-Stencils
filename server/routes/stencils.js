var fs = require('fs')
var path = require('path')

var gerberToSvg = require('gerber-to-svg')
var pcbStackup = require('pcb-stackup')
var idLayer = require('pcb-stackup/lib/layer-types').identify
var walk = require('walk')

var walker = walk.walk(path.join(__dirname, 'samples'))
var layers = []
var files = []

walker.on('file', add)
walker.on('end', pcb)

function add(root, file, next) {
  var item = path.join(root, file.name)
  files.push(item)
  next()
}

function pcb() {
  files.forEach(parse)

  function parse(filename) {
    var gerberString = fs.readFileSync(filename, 'utf-8')
    var layerType = idLayer(filename)
    var options = {
      object: true,
      drill: (layerType === 'drl')
    }
    var svgObj = gerberToSvg(gerberString, options)
    var p = {
      type: layerType,
      svg: svgObj
    }
    layers.push(p)
  }

  var stack = pcbStackup(layers, 'mb')
  stack.top.svg.width = '90%'
  stack.top.svg.height = '100%'
  stack.bottom.svg.width = '90%'
  stack.bottom.svg.height = '100%'
  var top = path.join(__dirname, 'top.svg')
  var bot = path.join(__dirname, 'bottom.svg')
  var topP = gerberToSvg(stack.top)
  var botP = gerberToSvg(stack.bottom)

  //fs.writeFileSync(top, topP)
  //fs.writeFileSync(bot, botP)
}
