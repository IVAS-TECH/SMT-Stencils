{walk} = require "walk"
{join} = require "path"

module.exports = (dir) ->
  promise = new Promise (resolve, reject) ->
    walker = walk dir
    map = {}
    walker.on "file", (root, file, next) ->
      info = file.name.split "."
      if info[1] not in ["coffee", "styl", "jade"]
        map["/#{info[0]}"] = join root, file.name
      next()
    walker.on "end", -> resolve map
  promise
