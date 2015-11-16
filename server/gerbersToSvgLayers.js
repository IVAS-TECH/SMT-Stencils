var gerberToSvg = require('gerber-to-svg')
var idLayer = require('pcb-stackup/lib/layer-types').identify

function gerbersToSvgLayers(files) {
  var top = {}
  var bot = {}
  var out = {}
  files.forEach(parse)
  top.svg["ng-class"] = "[(vm.stencil.position.side.toLowerCase().replace(' ', '-') || 'pcb-side'), (vm.style.stencil.lay ? 'stencil-layout' : 'stencil-centered')]"
  top.svg.viewBox = out.svg.viewBox
  top.svg.width = '90%'
  top.svg.height = '100%'
  var outline = out.svg._[0].g._[0]
  var figs = top.svg._[1].g._
  outline.path['ng-class'] = "vm.style.stencil.out ? 'stencil-outline' : 'stencil-no-outline'"
  figs.push(outline)
  result = {}
  result.top = gerberToSvg(top)
  //result.bot = gerberToSvg(bot)
  return result

  function parse(file) {
      var type = idLayer(file.name)
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
