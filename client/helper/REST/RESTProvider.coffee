http = require "http"
Promise = require "promise"

module.exports = ->

  _base = ""

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: ->

    (resorce) ->
      _path = "#{_base}/#{resorce}"

      make: (method, send) ->
        json = "application/json"
        path = _path
        if method in ["GET", "DELETE"] and send isnt ""
          path += "\/" + send

        new Promise (resolve, reject) ->
          req = http.request path: path, method: method, responseType: json, (res) ->

            response = ""

            res.on "data", (chunk) -> response += chunk

            res.on "end", ->
              resolve
                headers: res.headers
                data: JSON.parse response
                statusCode: res.statusCode

            res.on "error", (err) ->
              console.log err
              reject err

          if typeof send isnt "string"
            data = JSON.stringify send
            req.setHeader "Content-Type", json
            req.setHeader "Content-Length", data.length
            req.write data

          req.end()

      get: (send = "") -> @make "GET", send
      post: (send = {}) -> @make "POST", send
      put: (send = {}) -> @make "PUT", send
      delete: (send = "") -> @make "DELETE", send
      patch: (send = {}) -> @make "PATCH", send
