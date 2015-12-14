Promise = require "promise"
fs = require "fs-extra"
cheerio = require "cheerio"
{identify} = require "pcb-stackup/lib/layer-types"
{spawnSync} = require "child_process"
{join} = require "path"

convert = (paste, outline = "") ->
  #color = "--foreground=#FFFFFFFF"
  color = "--foreground=#000000FF"
  spawnSync "gerbv", ["-x", "svg", color, color, paste, outline], stdio: "inherit"
  out = fs.readFileSync "output.svg", "utf8"
  out.replace '<?xml version="1.0" encoding="UTF-8"?>', ""

samples = join __dirname, "../../client/resources"

#f = ["#{samples}/ATR150701-V2_F_Paste.gtp", "#{samples}/ATR150701-V2_Edge_Cuts.gbr"]
f = ["#{samples}/samples/clockblock-hub-F_Paste.gtp", "#{samples}/samples/clockblock-hub-Edge_Cuts.gbr"]
exports = (files) ->
  new Promise (resolve, reject) ->
    svg = []
    layers = ["tsp", "bsp", "out"]
    for file in files
      layer = identify file
      if layer in layers
        svg[layers.indexOf layer] = file
    top = cheerio.load convert svg[0], svg[2]
    #bottom = cheerio.load convert svg[1], svg[2]
    paths = top "path"
    out = []
    out = paths.filter (i, element) ->
      if element.attribs.style.match /fill:none/
        return element
    out.replaceWith "<g>#{out.toString()}</g>"
    attr = "ng-class"
    out.attr attr, "scopeCtrl.style.outline ? 'stencil-outline' : 'stencil-no-outline'"
    svg =  top "svg"
    svg.attr "width", "10%"
    svg.attr "height", "20%"
    svg.attr attr, "[(scopeCtrl.configuration.position.side || 'pcb-side'), (scopeCtrl.style.layout ? 'stencil-layout' : 'stencil-centered')]"
    resolve top: top.html()
      #resolve top

exports(f).then (c) ->
  console.log c.top
