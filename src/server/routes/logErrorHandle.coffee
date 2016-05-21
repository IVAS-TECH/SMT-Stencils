query = require "./../lib/query"
{createWriteStream} = require "fs"

module.exports = (log) ->
    stream = createWriteStream log, flags: "a"
    post: (req, res, next) ->
        stream.write (JSON.stringify req.body) + "\n", "utf-8", (err) ->
            if err then next err else query res
