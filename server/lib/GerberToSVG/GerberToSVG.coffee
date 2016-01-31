Promise = require "promise"
transform = require "./transform"

module.exports = (files, apertures = no) ->
  new Promise (resolve, reject) ->
    res = {}
    if apertures then res.apertures = 0
    top = files.top? and files.top.length
    bottom = files.bottom? and files.bottom.length

    send = -> resolve res

    transformLayer = (layer) ->
      new Promise (transfResolve, transfReject) ->
        (transform files[layer], files.outline, apertures)
          .then (svg) ->
            res[layer] = svg.preview
            if apertures then res.apertures += svg.apertures
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
