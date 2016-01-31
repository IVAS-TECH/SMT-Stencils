module.exports = ($scope, progressService, simpleDialogService) ->
  @$inject = ["$scope", "progressService", "simpleDialogService"]

  controller = @
  controller.files = {}
  controller.top = {}
  controller.bottom = {}

  progress = progressService $scope, "orderCtrl", "specificCtrl"

  controller.ifInvalid = ->
    if controller.invalid then simpleDialogService {}, "title-add-paste-layer"
    controller.invalid

  controller.back = -> progress no

  controller.next = -> if not controller.ifInvalid() then progress yes

  controller
