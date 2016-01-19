Promise = require "promise"
fs = require "fs-extra"
cheerio = require "cheerio"
path = require "path"
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
    console.log files
    res = {}
    if files[0]?
      res.top = formSVG files[0], files[2]
    if files[1]?
        res.bottom = formSVG files[1], files[2]
    console.log Object.keys res
    resolve res
