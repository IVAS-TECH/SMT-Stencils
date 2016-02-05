{join} = require "path"
query = require "./../lib/query"
{createWriteStream} = require "fs"

stream = createWriteStream (join __dirname, "../response.log"), flags: "a"

module.exports = post: (req, res, next) ->
  stream.write "#{JSON.stringify req.body}\n", "utf-8", (err) ->
    if err then next err
    else query res
