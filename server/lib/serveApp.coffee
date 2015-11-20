mapDir = require "./mapDir"

module.exports = (app) ->
  (req, res, next) ->
    map = mapDir(app)
    map.then (m) ->
      url = req.url
      if req.method is "GET" and m[url]?
        res.sendFile m[url]
        return
      else if url in ["/", "/about", "/tech", "/order", "/contact"]
        res.sendFile m["/index"]
        return
      res.sendFile m["/error"]
