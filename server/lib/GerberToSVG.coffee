Promise = require "promise"
fs = require "fs-extra"
cheerio = require "cheerio"
{identify} = require "pcb-stackup/lib/layer-types"
{spawnSync} = require "child_process"

convert = (paste, outline) ->
  colorPaste = "--foreground=#FFFFFFFF"
  args = ["-x", "svg", "-a", colorPaste, paste]
  if outline?
    args.push "--foreground=#000000FF"
    args.push outline
  spawnSync "gerbv", args, stdio: "inherit"
  output = "output.svg"
  out = fs.readFileSync output, "utf8"
  fs.removeSync output
  out.replace '<?xml version="1.0" encoding="UTF-8"?>', ""

formSVG = (paste, outline = null) ->
  if paste is undefined then return null
  $ = cheerio.load convert paste, outline
  paths = $ "path"
  out = paths.filter (i, element) ->
    if element.attribs.style.match /(0%,0,%0%)/
      return element
  attr = "ng-class"
  out.css "stroke-width", ""
  outHTML = "<g #{attr}=\"scopeCtrl.style.outline ? 'stencil-outline' : 'stencil-no-outline'\">#{out.toString()}</g>"
  out.remove()
  svg =  $ "svg"
  g = $ "g"
  paths = $ "path"
  g.append outHTML
  svg.attr "width", "80%"
  svg.attr "height", "90%"
  svg.attr attr, "[(scopeCtrl.configuration.position.side || 'pcb-side'), (scopeCtrl.style.layout ? 'stencil-layout' : 'stencil-centered')]"
  paths.css "fill", ""
  paths.css "stroke", ""
  $.html().replace((new RegExp "&apos;", "g"), "'").replace (new RegExp "\n", "g"), ""

module.exports = (files) ->
  new Promise (resolve, reject) ->
    svg = []
    layers = ["tsp", "bsp", "out"]
    for file in files
      layer = identify file
      if layer in layers
        svg[layers.indexOf layer] = file
    if svg.length
      resolve
        top: formSVG svg[0], svg[2]
        bottom: formSVG svg[1], svg[2]
    else
      resolve top: formSVG files[0]
