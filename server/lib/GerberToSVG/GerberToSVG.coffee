Promise = require "promise"
transform = require "./transform"

module.exports = (files) ->
  new Promise (resolve, reject) ->
    res = {}
    top = files.top?
    bottom = files.bottom?
    send = -> resolve res
    transformLayer = (layer, cb) ->
      (transform files[layer], files.outline).then (svg) ->
        res[layer] = svg
        cb()
    if top and bottom
      transformLayer "top", -> transformLayer "bottom", send
    else
      if top then transformLayer "top", send
      if bottom then transformLayer "bottom", send
