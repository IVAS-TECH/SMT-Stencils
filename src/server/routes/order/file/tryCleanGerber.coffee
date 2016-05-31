fs = require "fs"
{parse} = require "path"

module.exports = (layer, gcloud = no) ->
    (req, res, next) ->
        file = req.gerbers[layer]
        if not file? then next()
        else
            localClean = -> fs.unlink file, (err) -> if err then next err else next()
            if gcloud
                if not req.fileStorage? then localClean()
                else (req.fileStorage.file (parse file).base).delete (err) ->
                    if err then next err else fs.access file, (accErr) ->
                        if accErr then next() else localClean()
            else localClean()
