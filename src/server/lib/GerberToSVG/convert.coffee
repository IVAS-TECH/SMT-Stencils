{spawn} = require "child_process"
randomString = require "randomstring"
fs = require "fs"
{join} = require "path"

module.exports = (paste, outline) ->
  new Promise (resolve, reject) ->
    output = join __dirname, "../../files/tmp/#{randomString.generate()}.svg"
    error = no
    args = ["-x", "svg", "-o", output, "-a", "--foreground=#FFFFFFFF", paste]
    if outline?
        args.push "--foreground=#000000FF"
        args.push outline
    gerbv = spawn "gerbv", args
    gerbv.stderr.on "data", (data) ->
        str = data.toString()
        if str.includes "Unknown file type" or str.includes "could not read" then error = yes
    gerbv.on "error", reject
    gerbv.on "close", ->
      progress = (err, server, cb) -> if err then (if server then reject err else resolve null) else cb()
      progress error, no, -> fs.access output, (accessErr) ->
        progress accessErr, no, -> fs.readFile output, "utf8", (readErr, data) ->
          progress readErr, yes, -> fs.unlink output, (removeErr) ->
            progress removeErr, yes, -> resolve data.replace '<?xml version="1.0" encoding="UTF-8"?>', ""
