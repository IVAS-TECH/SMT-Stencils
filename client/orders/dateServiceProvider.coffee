module.exports = ->

  separator = "\/"

  $get: ->
    format: @formater()
    parse: @parser()
    compatible: (date,end) ->
      @parse @format date
    iterator: (start, end) ->
      begging = @compatible date
      value: begging
      inc: ->
        begging.setDate begging.getDate() + 1
        begging <= end


  formater: ->
    (date) ->
      info = new Date date
      [info.getDate(), info.getMonth() + 1, info.getFullYear()].join separator

  parser: ->
    (date) ->
      info = date.split separator
      new Date info[2], info[1] - 1, info[0]
