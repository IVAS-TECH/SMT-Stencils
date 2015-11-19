var gerberToSvg = require('gerber-to-svg')
var idLayer = require('pcb-stackup/lib/layer-types').identify

function gerbersToSvgLayers(files) {
  var top = {}
  var bot = {}
  var out = {}
  files.forEach(parse)
  top.svg["ng-class"] = "[(vm.stencil.position.side.toLowerCase().replace(' ', '-') || 'pcb-side'), (vm.stencil.style.lay ? 'stencil-layout' : 'stencil-centered')]"
  top.svg.viewBox = out.svg.viewBox
  top.svg.width = '80%'
  top.svg.height = '90%'
  var outline = out.svg._[0].g._[0]
  var figs = top.svg._[1].g._
  outline.path['ng-class'] = "vm.stencil.style.out ? 'stencil-outline' : 'stencil-no-outline'"
  figs.push(outline)
  result = {}
  result.top = gerberToSvg(top)
  //result.bot = gerberToSvg(bot)
  return result

  function parse(file) {
      var type = idLayer(file.path)
      var opts = {}
      opts.object = true
      opts.drill = type === 'drl'
      var svg = gerberToSvg(file.content, opts)
      if (type === 'tsp')
          top = svg
      if (type === 'bsp')
          bot = svg
      if (type === 'out')
          out = svg
  }
}

module.exports = gerbersToSvgLayers
