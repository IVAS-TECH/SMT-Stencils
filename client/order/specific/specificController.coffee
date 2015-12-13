module.exports = (RESTHelperService) ->
  controller = @
  controller.$inject = ["RESTHelperService"]

  controller.files = []
  controller.top = {}
  controller.bottom = {}

  controller.upload = ->
    RESTHelperService.upload.preview controller.files, (res) ->
      controller.top.view = res.top
      if res.bottom?
        controller.bottom.view = res.bottom

  controller
