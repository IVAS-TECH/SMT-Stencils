{join} = require "path"

module.exports = (dir) ->
    get: (req, res) ->
        (res.status 200).sendFile (join dir, req.params.file), headers: "Content-Type": "text/html"
    params: get: "file"
