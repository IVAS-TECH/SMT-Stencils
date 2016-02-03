query = require "./../query"
transform = require "./transform"

module.exports = (middleware) ->

  if middleware isnt "send" then (req, res, next) ->

    if not req.stencil? then req.stencil = apertures: {}

    if req.gerbers[middleware]? and req.gerbers[middleware].length
      (transform req.gerbers[middleware], req.gerbers.outline)
        .then (stencil) ->
          if stencil? and typeof stencil is "object"
            req.stencil[middleware] = stencil.preview
            req.stencil.apertures[middleware] = stencil.apertures
          else req.stencil[middleware] = stencil
          next()
        .catch next
    else next()

  else (req, res) -> query res, req.stencil
