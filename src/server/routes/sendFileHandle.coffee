{join} = require "path"

module.exports = (dir, gcloud = no) ->
    get: (req, res) ->
        file = (join dir, req.params.file)
        send = -> (res.status 200).sendFile file, headers: "Content-Type": "text/html"
        if gcloud and req.fileStorage? then (req.fileStorage.file file).download destination: file, (err) ->
            console.log "download: ", file, err
            if err then next err else send()
        else send()
    params: get: "file"
