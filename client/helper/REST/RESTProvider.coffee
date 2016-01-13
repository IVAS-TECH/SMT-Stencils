http = require "http"
Promise = require "promise"

module.exports = ->

  _base = ""

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: ->

    (resource) ->
      _path = "#{_base}/#{resource}"

      rest = make: (method, send) ->
        json = "application/json"
        path = _path
        if method in ["GET", "DELETE"] and send isnt ""
          path += "\/" + send

        new Promise (resolve, reject) ->
          request =
            path: path
            method: method
            responseType: json

          req = http.request request, (res) ->

            response = ""

            res.on "data", (chunk) -> response += chunk

            res.on "end", ->
              resolve
                headers: res.headers
                data: JSON.parse response
                statusCode: res.statusCode

            res.on "error", reject

          if typeof send isnt "string"
            data = JSON.stringify send
            req.setHeader "Content-Type", json
            req.setHeader "Content-Length", data.length
            req.write data

          req.end()

      rest.get = (send = "") -> rest.make "GET", send
      rest.post = (send = {}) -> rest.make "POST", send
      rest.put = (send = {}) -> rest.make "PUT", send
      rest.delete = (send = "") -> rest.make "DELETE", send
      rest.patch = (send = {}) -> rest.make "PATCH", send

      rest
