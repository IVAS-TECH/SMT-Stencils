Promise = require "promise"
fs = require "fs-extra"
cheerio = require "cheerio"
path = require "path"
{identify} = require "pcb-stackup/lib/layer-types"
{spawnSync} = require "child_process"

layers = ["tsp", "bsp", "out"]

identifyLayer = (layer, files) ->
  justFile = (f) ->
    splited = f.split path.sep
    splited[splited.length - 1]

  test = (searchIn, searchFor) ->
    tester = (search) -> not (searchIn.match new RegExp search, "i")?
    if not searchFor.match /\ /
      tester searchFor
    else
      (tester token for token in (searchFor.split " ")).every (element) -> element is true

  filter = (justFile file for file in files)

  tryIdentify = (condition) ->
    (filter.filter condition)[0]

  switch layer
    when "top"
      top = tryIdentify (e) -> identify e is layer[0]
      if top? then return top
      top = tryIdentify (e) -> test e, "top paste"
      if top? then return top
      top = tryIdentify (e) -> test e, "top"
      if top? then return top
      return null
    when "bot"
      bot = tryIdentify (e) -> identify e is layer[1]
      if bot? then return bot
      bot = tryIdentify (e) -> test e, "bot paste"
      if bot? then return bot
      bot = tryIdentify (e) -> test e, "bot"
      if bot? then return bot
      return null
    when "out"
      out = tryIdentify (e) -> identify e is layer[1] or test e, "out" or test e, "border"
      if out? then return out
      return null

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

formSVG = (paste, outline) ->
  if paste is undefined then return null

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
  svg.attr attr, "[(scopeCtrl.configuration.position.side || 'pcb-side'), (scopeCtrl.style.layout ? 'stencil-layout' : 'stencil-centered')]"
  (filter paths, /100%,100%,100%/).css "fill", ""
  replaceAll (removeAll $.html(), "\n"), "&apos;", "'"

module.exports = (files) ->
  new Promise (resolve, reject) ->
    svg = [
      identifyLayer "top", files
      identifyLayer "bot", files
      identifyLayer "out", files
    ]
    console.log svg
    res = top: formSVG svg[0], svg[2]
    if svg[1]?
        res.bottom = formSVG svg[1], svg[2]
    resolve res
