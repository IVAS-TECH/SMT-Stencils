{spawn} = require "child_process"
fs = require "fs-extra"
Promise = require "promise"
randomString = require "random-string"

module.exports = (paste, outline) ->
  new Promise (resolve, reject) ->
    output = "./files/tmp/#{randomString()}.svg"
    args = ["-x", "svg", "-o", output, "-a", "--foreground=#FFFFFFFF", paste]
    if outline?
      args.push "--foreground=#000000FF"
      args.push outline
    gerbv = spawn "gerbv", args, stdio: "inherit"
    gerbv.on "close", ->
      fs.readFile output, "utf8", (readErr, data) ->
        if readErr then reject readErr
        fs.remove output, (removeErr) ->
          if removeErr
            reject removeErr
          else
            resolve data.replace '<?xml version="1.0" encoding="UTF-8"?>', ""
