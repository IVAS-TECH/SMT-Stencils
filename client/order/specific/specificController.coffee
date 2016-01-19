module.exports = ($scope, progressService) ->
  @$inject = ["$scope", "progressService"]

  controller = @
  controller.files = {}
  controller.top = {}
  controller.bottom = {}

  progress = progressService $scope, "orderCtrl", "specificCtrl"

  controller.back = -> progress no

  controller.next = -> progress yes

  controller
