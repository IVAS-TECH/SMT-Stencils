module.exports = (RESTHelperService, $scope, progressService) ->
  controller = @
  controller.$inject = ["RESTHelperService", "$scope", "progressService"]
  controller.files = []
  controller.top = {}
  controller.bottom = {}

  progress = progressService $scope, "orderCtrl", "specificCtrl"

  controller.upload = ->
    RESTHelperService.upload.preview controller.files, (res) ->
      controller.top.view = res.top
      controller.bottom.view = res.bottom
      $scope.$digest()

  controller.back = -> progress.move "configuration"

  controller.next = -> progress.move "addresses"

  controller
