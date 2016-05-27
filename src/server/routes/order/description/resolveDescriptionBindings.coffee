module.exports = (template, populate) ->
    result = []
    for line in template
        match = line.match /[.\&\@]/
        bind = if match? then populate[line.replace "&@", ""]
        result.push if bind? then "" + bind else line
    result
