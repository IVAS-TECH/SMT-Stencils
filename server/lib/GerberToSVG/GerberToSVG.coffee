Promise = require "promise"
transform = require "./transform"

module.exports = (files, price = no) ->
  new Promise (resolve, reject) ->
    res = {}
    if price then res.price = 0
    top = files.top? and files.top.length
    bottom = files.bottom? and files.bottom.length
    send = -> resolve res
    transformLayer = (layer, cb) ->
      (transform files[layer], files.outline, price).then (svg) ->
        res[layer] = svg.preview
        console.log svg.price
        if price then res.price += svg.price
        cb()
    if top and bottom
      transformLayer "top", -> transformLayer "bottom", send
    else
      if top then transformLayer "top", send
      if bottom then transformLayer "bottom", send
