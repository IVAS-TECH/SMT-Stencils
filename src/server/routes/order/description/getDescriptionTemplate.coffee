{join} = require "path"
{readFile} = require "fs"
templates = join __dirname, "../../../descriptionTemplates"
console.log templates

module.exports = (status, language) ->
    new Promise (resolve, reject) ->
        readFile (join templates, "#{status}_#{language}.txtmp"), "utf8", (err, template) ->
            console.log "template", err, template
            if err then reject err else resolve template.split "\n"
