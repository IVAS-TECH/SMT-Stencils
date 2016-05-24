{join} = require "path"
{readFile} = require "fs"
templates = join __dirname, "./../../../descriptionTemplates"

module.exports = (status, language) ->
    new Promise (resolve, reject) ->
        readFile (join templates, "#{status}_#{language}.txtmp"), "utf8", (err, template) ->
            if err then reject err else resolve template.split "\n"
