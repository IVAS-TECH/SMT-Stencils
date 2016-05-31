fs = require "fs"

module.exports = (layer, gcloud = no) ->
    (req, res, next) ->
        file = req.gerbers[layer]
        if not file? then next()
        else
            localClean = -> fs.unlink file, (err) -> if err then next err else next()
            if gcloud
                if not req.fileStorage? then localClean()
                else (req.fileStorage.file file).delete (err) -> if err then next err else fs.access file, (accErr) ->
                    console.log "deleting", file, err
                    if accErr then next() else localClean()
            else localClean()
