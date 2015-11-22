{join} = require "path"

mapApp = (app) ->
  app = join app, "app"
  {
    "/style": join app, "style.css"
    "/bundle": join app, "bundle.js"
    "/index": join app, "index.html"
    "/error": join app, "error.html"
  }

module.exports = (app) ->
  (req, res, next) ->
    map = mapApp(app)
    url = req.url
    if req.method is "GET"
      if map[url]?
        res.sendFile map[url]
        return
      else if url in ["/", "/about", "/tech", "/order", "/contact"]
        res.sendFile map["/index"]
        return
    res.sendFile map["/error"]
