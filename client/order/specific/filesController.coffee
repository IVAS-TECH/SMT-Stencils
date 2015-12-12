module.exports = ->
  controller = @
  controller.range = [1..3]
  controller.removeFile = (event, index) ->
    if controller.remove
      event.stopPropagation()
      controller.files.splice index, 1
  controller
