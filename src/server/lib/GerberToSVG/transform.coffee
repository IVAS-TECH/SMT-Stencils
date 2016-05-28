cheerio = require "cheerio"
convert = require "./convert"

module.exports = (paste, outline) ->
  new Promise (resolve, reject) ->
    (convert paste, outline)
      .then (svg) ->
        if not svg? then resolve svg
        else
          $ = cheerio.load svg
          paths = $ "path"
          apertures = paths.length
          if not apertures then resolve no
          else
            filter = (paths, search) ->
              paths.filter (i, element) -> if element.attribs.style.match search then element
            replaceAll = (str, search, replace) -> str.replace (new RegExp search, "g"), replace
            removeAll = (str, search) -> replaceAll str, search, ""
            svg =  $ "svg"
            attr = "ng-class"
            out = filter paths, /0%,0%,0%/
            out.css "stroke-width", ""
            out.css "stroke", ""
            outHTML = "<g #{attr}=\"scopeCtrl.configurationObject.style.outline
              ? 'stencil-outline' : 'stencil-no-outline'\">#{out.toString()}</g>"
            out.remove()
            ($ "g").append outHTML
            svg.attr "width", "80%"
            svg.attr "height", "90%"
            svg.attr attr, "[(scopeCtrl.configurationObject.position.side || 'pcb-side'),
              (scopeCtrl.configurationObject.style.layout ?
              'stencil-layout' : 'stencil-centered')]"
            (filter paths, /100%,100%,100%/).css "fill", ""
            resolve apertures: apertures, preview: replaceAll (removeAll $.html(), "\n"), "&apos;", "'"
      .catch reject
