{join} = require "path"

map = (app) ->
  m = {}
  app = join app, "app"
  m["/dependencies"] = join app, "dependencies.js"
  m["/angular-material"] = join app, "angular-material.css"
  m["/style"] = join app, "style.css"
  m["/bundle"] = join app. "bundle.js"
  m["/index"] = join app, "index.html"
  m["/error"] = join app, "error.html"
  m

module.exports = (app) ->
  (req, res, next) ->
    map = mapApp(app)
    url = req.url
    if req.method is "GET"
      if m[url]?
        res.appFile m[url]
        return
      else if url in ["/", "/about", "/tech", "/order", "/contact"]
        res.appFile m["/index"]
        return
    res.appFile m["/error"]
