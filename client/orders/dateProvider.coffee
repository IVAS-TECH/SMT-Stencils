module.exports = ->

  separator = "\/"

  $get: ->
    format: @formater()
    parse: @parser()

  formater: ->
    (date) ->
      info = new Date date
      [info.getDate(), info.getMonth() + 1, info.getFullYear()].join separator

  parser: ->
    (date) ->
      info = date.split separator
      new Date info[2], info[1], info[0]
