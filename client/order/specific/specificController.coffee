module.exports = (RESTHelperService) ->
  controller = @
  controller.$inject = ["RESTHelperService"]
  controller.files = []
  controller.top = {}
  controller.bottom = {}

  controller.upload = ->
    RESTHelperService.upload.preview controller.files, (res) ->
      test = (model) -> if model? then model else undefined
      controller.top.view = test res.top
      controller.bottom.view = test res.bottom

  controller
