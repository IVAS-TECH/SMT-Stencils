Promise = require "promise"
fs = require "fs-extra"
cheerio = require "cheerio"
svgPath = require "svgpath"
{identify} = require "pcb-stackup/lib/layer-types"
{spawnSync} = require "child_process"

{join} = require "path"

convert = (name) ->
  spawnSync "gerbv", ["-x", "svg", "--border=5%", "--foreground=#555555FF", name], stdio: "inherit"
  out = fs.readFileSync "output.svg", "utf8"
  out.replace '<?xml version="1.0" encoding="UTF-8"?>', ""

samples = join __dirname, "../../client/resources"

f = ["#{samples}/ATR150701-V2_F_Paste.gtp", "#{samples}/ATR150701-V2_Edge_Cuts.gbr"]
#f = ["#{samples}/samples/clockblock-hub-F_Paste.gtp", "#{samples}/samples/clockblock-hub-Edge_Cuts.gbr"]
exports = (files) ->
  new Promise (resolve, reject) ->
    svg = []
    layers = ["tsp", "bsp", "out"]
    for file in files
      layer = identify file
      if layer in layers
        svg[layers.indexOf layer] = cheerio.load convert file
      resolve svg

exports(f).then (c) ->
  g0 = c[0] "g"
  svg0 = c[0] "svg"
  size0 = svg0.attr "viewbox"
  size = size0.split " "
  x0 = parseInt size[2]
  y0 = parseInt size[3]
  svg2 = c[2] "svg"
  size2 = svg2.attr "viewbox"
  size = size2.split " "
  x2 = parseInt size[2]
  y2 = parseInt size[3]
  x = (x2 - x0) / 2 - 4
  y = (y2 - y0) / 2 - 1
  for path in c[0] "path"
    path.attribs.d = svgPath(path.attribs.d).translate(x, y).toString()
  g0.append svg2.html()
  svg0.attr "viewbox", size2
  console.log c[0].html()
