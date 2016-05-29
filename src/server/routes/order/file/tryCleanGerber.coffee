fs = require "fs"

module.exports = (layer) ->
    (req, res, next) ->
        file = req.gerbers[layer]
        if not file? then next() else fs.unlink file, (err) ->
            if err then next err else next()
