query = require "./../query"
transform = require "./transform"

module.exports = (middleware) ->
    if middleware isnt "send" then (req, res, next) ->
        if not req.stencil? then req.stencil = apertures: {}
        if req.gerbers[middleware]?
            (transform req.gerbers[middleware], req.gerbers.outline).then ((stencil) ->
                if stencil? and typeof stencil.preview is "string"
                    req.stencil[middleware] = stencil.preview
                    req.stencil.apertures[middleware] = stencil.apertures
                else req.stencil[middleware] = stencil
                next()
            ), next
        else next()
    else (req, res, next) -> query res, req.stencil
