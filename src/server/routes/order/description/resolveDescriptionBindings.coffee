module.exports = (template, populate) ->
    result = []
    for line in template
        bind = null
        if (line.match /[^&@]/)? then bind = populate[line.replace "&@", ""]
        result.push if bind? then "" + bind else line
    result
