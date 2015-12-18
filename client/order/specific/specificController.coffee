module.exports = (RESTHelperService, $scope, progressService) ->
  controller = @
  controller.$inject = ["RESTHelperService", "$scope", "progressService"]
  controller.files = []
  controller.top = {}
  controller.bottom = {}

  progress = progressService $scope, "orderCtrl", "specificCtrl"

  controller.upload = ->
    RESTHelperService.upload.preview controller.files, (res) ->
      test = (model) -> if model? then model else undefined
      controller.top.view = test res.top
      controller.bottom.view = test res.bottom

  controller.back = -> progress.move "configuration"

  controller.next = -> progress.move "addresses"

  controller
