{join} = require "path"

module.exports = (dir, gzip = yes) ->
    sendFile = (file) ->
        send = join dir, file
        (req, res) ->
            if gzip then res.set "Content-Encoding", "gzip"
            (res.status 200).sendFile send
