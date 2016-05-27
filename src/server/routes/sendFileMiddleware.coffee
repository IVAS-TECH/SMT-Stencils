{join} = require "path"

module.exports = (dir, gzip = yes) ->
    sendFile = (file, deduc = yes) ->
        send = join dir, file
        (req, res) ->
            if gzip then res.set "Content-Encoding", "gzip"
            args = [send, headers: "Content-Type": "text/html"]
            if deduc then args.pop()
            status = res.status 200
            status.sendFile.apply status, args
