{spawn} = require "child_process"
fs = require "fs-extra"
Promise = require "promise"

module.exports = (paste, outline) ->
  new Promise (resolve, reject) ->
    output = "output.svg"
    args = ["-x", "svg", "-a", "--foreground=#FFFFFFFF", paste]
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
