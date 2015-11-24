http = require "http"
Promise = require "promise"

json = "application/json"

class HTTP
  @form: (res, data) -> headers: res.headers, statusCode: res.statusCode, data: JSON.parse data
  constructor: (base = "") -> @base = "/#{base}"
  take: (extend = "") ->
    @base += "/#{extend}"
    @
  get: (resource = "") ->
    opts = method: "GET", responseType: json, path: if resource isnt "" then "#{@base}/#{resource}" else @base
    promise = new Promise (resolve, reject) ->
      req = http.request opts, (res) ->
        response = ""
        res.on "data", (chunk) -> response += chunk
        res.on "end", -> resolve HTTP.form res, response
        res.on "error", (err) -> reject err
      req.end()
  make: (method, send = {}) ->
    opts = path: @base, method: method, responseType: json
    promise = new Promise (resolve, reject) ->
      req = http.request opts, (res) ->
        response = ""
        res.on "data", (chunk) -> response += chunk
        res.on "end", -> resolve HTTP.form res, response
        res.on "error", (err) -> reject err
      data = JSON.stringify send
      req.setHeader "Content-Type", json
      req.setHeader "Content-Length", data.length
      req.write data
      req.end()
  post: (send) -> @make "POST", send
  put: (send) -> @make "PUT", send
  del: (send) -> @make "DELETE", send
  patch: (send) -> @make "PATCH", send

module.exports = HTTP
