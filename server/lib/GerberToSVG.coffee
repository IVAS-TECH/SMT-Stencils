Promise = require "promise"
fs = require "fs-extra"
cheerio = require "cheerio"
path = require "path"
{identify} = require "pcb-stackup/lib/layer-types"
{spawnSync} = require "child_process"

convert = (paste, outline) ->
  args = ["-x", "svg", "-a", "--foreground=#FFFFFFFF", paste]
  if outline?
    args.push "--foreground=#000000FF"
    args.push outline
  spawnSync "gerbv", args, stdio: "inherit"
  output = "output.svg"
  out = fs.readFileSync output, "utf8"
  fs.removeSync output
  out.replace '<?xml version="1.0" encoding="UTF-8"?>', ""

formSVG = (paste, outline) ->
  if not paste? then return null

  filter = (paths, search) ->
    paths.filter (i, element) ->
      if element.attribs.style.match search
        return element

  replaceAll = (str, search, replace) ->
    str.replace (new RegExp search, "g"), replace

  removeAll = (str, search) -> replaceAll str, search, ""

  $ = cheerio.load convert paste, outline
  paths = $ "path"
  svg =  $ "svg"
  attr = "ng-class"
  out = filter paths, /0%,0%,0%/
  out.css "stroke-width", ""
  out.css "stroke", ""
  outHTML = "<g #{attr}=\"scopeCtrl.style.outline ? 'stencil-outline' : 'stencil-no-outline'\">#{out.toString()}</g>"
  out.remove()
  ($ "g").append outHTML
  svg.attr "width", "80%"
  svg.attr "height", "90%"
  svg.attr attr, "[(scopeCtrl.configurationObject.position.side || 'pcb-side'), (scopeCtrl.style.layout ? 'stencil-layout' : 'stencil-centered')]"
  (filter paths, /100%,100%,100%/).css "fill", ""
  replaceAll (removeAll $.html(), "\n"), "&apos;", "'"

module.exports = (files) ->
  new Promise (resolve, reject) ->
    justFile = (f) ->
      splited = f.split path.sep
      splited[splited.length - 1]

    filter = (justFile file for file in files)
    layers = ["tsp", "bsp", "out"]

    identifyLayer = (layer) ->

      test = (searchIn, searchFor) ->
        tester = (search) -> (searchIn.match new RegExp search, "i")?
        if not searchFor.match /\ / then tester searchFor
        else (tester token for token in searchFor.split " ").every (element) ->
          element is true

      tryIdentify = (condition) ->
        (files.filter (element, index) ->
          condition filter[index])[0]

      returnLayer = (conditions) ->
        for condition in conditions
          identified = tryIdentify condition
          if identified?
            return identified
        return null

      if layer is layers[2]
        return returnLayer [
          (e) -> (identify e) is layers[2]
          (e) -> test e, "border"
          (e) -> test e, layers[2]
        ]
      else
        tested = if layer is layers[0] then "top" else if layer is layers[1] then "bot"
        return returnLayer [
          (e) -> (identify e) is layers[layers.indexOf layer]
          (e) -> test e, "#{tested} paste"
          (e) -> test e, tested
        ]

    svg = (identifyLayer layer for layer in layers)
    res = success: true, top: formSVG svg[0], svg[2]
    if svg[1]?
        res.bottom = formSVG svg[1], svg[2]
    resolve res
