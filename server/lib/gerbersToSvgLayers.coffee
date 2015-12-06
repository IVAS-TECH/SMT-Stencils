gerberToSvg = require "gerber-to-svg"
{identify} = require "pcb-stackup/lib/layer-types"

module.exports = (files) ->
  top = bot = out = {}
  parse = (gerber) ->
    type = identify gerber.path
    svg = gerberToSvg gerber.content, object: true, drill: type is "drl"
    if type is "tsp" then top = svg
    if type is "bsp" then bot = svg
    if type is "out" then out = svg
  parse file for file in files
  top.svg.viewBox = out.svg.viewBox
  top.svg.width = "80%"
  top.svg.height = "90%"
  outline = out.svg._[0].g._[0]
  figs = top.svg._[1].g._
  top.svg["ng-class"] = "[(x.configuration.position.side || 'pcb-side'), (x.layout ? 'stencil-layout' : 'stencil-centered')]"
  outline.path["ng-class"] = "x.outline ? 'stencil-outline' : 'stencil-no-outline'"
  figs.push outline
  top: gerberToSvg top
