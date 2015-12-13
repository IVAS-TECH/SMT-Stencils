module.exports = ->
  controller = @

  controller.columns = ->
    for i in [7..2]
      if controller.files.length % i is 0
        controller.rows = [1..i]
        return [1..controller.files.length / i]

  controller.removeFile = (event, index) ->
    if controller.remove
      event.stopPropagation()
      controller.files.splice index, 1
  controller
