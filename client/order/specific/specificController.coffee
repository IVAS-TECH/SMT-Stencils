module.exports = (Upload) ->
  controller = @
  controller.$inject = ["Upload"]
  controller.files = []
  controller.removeFile = (event, index) ->
    event.stopPropagation()
    controller.files.splice index, 1
  controller
