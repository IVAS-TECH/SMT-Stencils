send = require "./send"

module.exports =

  successful: (err, doc) -> (@noErr err) and doc?

  noErr: (err) -> not err?

  basicHandle: (err, doc, res, next) ->
    if @successful err, doc
      send res
    else next err
