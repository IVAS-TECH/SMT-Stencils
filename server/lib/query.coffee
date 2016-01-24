send = require "./send"

module.exports =

  successful: (err, doc) -> (@noErr err) and doc?

  noErr: (err) -> not err?

  basicHandle: (err, doc, res, next, key) ->
    if @successful err, doc
      if key?
        send res, "#{key}": doc
      else send res
    else next err
