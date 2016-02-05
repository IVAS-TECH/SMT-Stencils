{join} = require "path"
query = require "./../lib/query"
{createWriteStream} = require "fs"

stream = createWriteStream (join __dirname, "../client.log"), flags: "a"

module.exports = post: (req, res, next) ->
  stream.write "error: #{req.body.error}\n", "utf-8", (err) ->
    if err then next err
    else query res
