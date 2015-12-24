http = require "http"
Promise = require "promise"
json = "application/json"

class HTTP
  @form: (res, data) -> headers: res.headers, statusCode: res.statusCode, data: JSON.parse data
  constructor: (base = "") -> @base = "/#{base}"
  take: (extend = "") ->
    @base += "/#{extend}"
    @
  make: (method, send) ->
    path = if method in ["GET", "DELETE"] and send isnt "" then "#{@base}/#{send}" else @base
    promise = new Promise (resolve, reject) ->
      req = http.request path: path, method: method, responseType: json, (res) ->
        response = ""
        res.on "data", (chunk) -> response += chunk
        res.on "end", -> resolve HTTP.form res, response
        res.on "error", (err) ->
          console.log err
          reject err
      if typeof send isnt "string"
        console.log "ASASAS", JSON.stringify send
        data = JSON.stringify send
        console.log data
        req.setHeader "Content-Type", json
        req.setHeader "Content-Length", data.length
        req.write data
      req.end()
  get: (send = "") -> @make "GET", send
  post: (send = {}) -> @make "POST", send
  put: (send = {}) -> @make "PUT", send
  delete: (send = "") -> @make "DELETE", send
  patch: (send = {}) -> @make "PATCH", send

module.exports = HTTP
