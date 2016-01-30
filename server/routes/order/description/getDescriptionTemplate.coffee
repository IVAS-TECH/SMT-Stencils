{join} = require "path"
fs = require "fs"
Promise = require "promise"
templates = join __dirname, "../../../../descriptionTemplates"

module.exports = (status, lenguage, populate) ->

  requested = join templates, status + "_" + lenguage + ".txt"

  new Promise (resolve, reject) ->

    fs.readFile requested, "utf8", (err, template) ->

      if err then reject err
      else
        tmp = template.split "\n"
        tmp.pop()
        resolve tmp
