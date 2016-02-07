{join} = require "path"

module.exports = (dir) ->
  sendFile = (file, gzip) ->
    send = join dir, file
    (req, res) ->
      if gzip then res.set "Content-Encoding", "gzip"
      res.status(200).sendFile send
