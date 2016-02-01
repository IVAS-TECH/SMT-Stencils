send = require "./../send"
Promise = require "promise"
transform = require "./transform"

module.exports = (middleware) ->

  if middleware is "transform" then (req, res, next) ->

    files = req.gerbers

    req.stencil = apertures: {}

    fileForLayer = (layer) -> files[layer]? and files[layer].length

    top = fileForLayer "top"
    bottom = fileForLayer "bottom"

    transformLayer = (layer) ->
      new Promise (resolve, reject) ->
        (transform files[layer], files.outline)
          .then (svg) ->
            if svg? and typeof svg is "object"
              req.stencil[layer] = svg.preview
              req.stencil.apertures[layer] = svg.apertures
            else stencil[layer] = svg
            resolve()
          .catch reject

    if top and bottom
      transforms = [
        transformLayer "top"
        transformLayer "bottom"
      ]
      transforms[0]
        .then -> transforms[1].then next, -> next()
        .catch -> transforms[1].then next, next
    else
      if top then (transformLayer "top").then next, next
      if bottom then (transformLayer "bottom").then next, next

  else (req, res, next) -> send res, req.stencil
