http = require "http"
Promise = require "promise"

module.exports = ->

  base = ""

  setBase: (b) -> base = b

  $get: ->

    (resorce) ->
      reqPath = "\/" + if base isnt "" then "#{base}/#{resorce}" else resorce

      make = (method, send) ->
        json = "application/json"
        path = if method in ["GET", "DELETE"] and send isnt "" then "#{reqPath}/#{send}" else reqPath

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

      get: (send = "") -> make "GET", send
      post: (send = {}) -> make "POST", send
      put: (send = {}) -> make "PUT", send
      delete: (send = "") -> make "DELETE", send
      patch: (send = {}) -> make "PATCH", send
