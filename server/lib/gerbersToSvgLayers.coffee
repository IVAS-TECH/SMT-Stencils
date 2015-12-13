gerberToSvg = require "gerber-to-svg"
{identify} = require "pcb-stackup/lib/layer-types"

module.exports = (files) ->
  top = null
  bottom = null
  out = null
  err = []
  parse = (gerber) ->
    type = identify gerber.path
    try
      svg = gerberToSvg gerber.content, object: true, drill: type is "drl", warnArr: err
    catch e
      console.log "error parsing all", e
    if type is "tsp" then top = svg
    if type is "bsp" then bottom = svg
    if type is "out" then out = svg
  parse file for file in files
  console.log "warnings", err
  console.log "top and bot", top, bottom
  if not top? or not bottom?
    return top: top, bottom: bottom

  top.svg.viewBox = out.svg.viewBox
  top.svg.width = "80%"
  top.svg.height = "90%"
  outline = out.svg._[0].g._[0]
  figs = top.svg._[1].g._
  top.svg["ng-class"] = "[(scopeCtrl.configuration.position.side || 'pcb-side'), (scopeCtrl.style.layout ? 'stencil-layout' : 'stencil-centered')]"
  outline.path["ng-class"] = "scopeCtrl.style.outline ? 'stencil-outline' : 'stencil-no-outline'"
  figs.push outline
  topSVG = null
  bottomSVG = null
  try
    topSVG = gerberToSvg top
    if bottom.svg._.length > 0
      bottomSVG = gerberToSvg bottom
  catch e
    console.log "error parsing", e
  top: topSVG
  bottom: bottomSVG
