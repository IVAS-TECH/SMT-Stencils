Promise = require "promise"
transform = require "./transform"

module.exports = (files, apertures = no) ->
  new Promise (resolve, reject) ->
    res = {}
    if apertures then res.apertures = {}
    top = files.top? and files.top.length
    bottom = files.bottom? and files.bottom.length

    send = -> resolve res

    transformLayer = (layer) ->
      new Promise (transfResolve, transfReject) ->
        (transform files[layer], files.outline, apertures)
          .then (svg) ->
            if svg? and typeof svg is "object"
              res[layer] = svg.preview
            else res[layer] = svg
            if apertures then res.apertures[layer] = svg.apertures
            transfResolve()
          .catch transfReject

    if top and bottom
      transforms = [
        transformLayer "top"
        transformLayer "bottom"
      ]
      transforms[0]
        .then -> transforms[1].then send, send
        .catch -> transforms[1].then send, reject
    else
      if top then (transformLayer "top").then send, reject
      if bottom then (transformLayer "bottom").then send, reject
