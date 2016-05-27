query = require "./../lib/query"
{createWriteStream} = require "fs"

module.exports = (log) ->
    stream = createWriteStream log, flags: "a"
    post: (req, res, next) ->
        stringify = (val) ->
            if typeof val is "object" and val?
                return if Object.keys(val).length then format val else return "()"
            return val
        format = (obj) ->
            str = (key + "=" + (stringify val) + " " for key, val of obj).join ""
            str = (str.slice 0, -1) while str[str.length - 1] is " "
            "(" + str + ")"
        stream.write (format req.body) + "\n", "utf-8", (err) ->
            if err then next err else query res
