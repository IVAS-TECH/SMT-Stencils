{join} = require "path"
fs = require "fs"
templates = join __dirname, "../../../../descriptionTemplates"

module.exports = (status, language, populate) ->
  new Promise (resolve, reject) ->
    fs.readFile (join templates, "#{status}_#{language}.txtmp"), "utf8", (err, template) ->
      if err then reject err else resolve template.split "\n"