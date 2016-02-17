controller = ($scope, progressService, simpleDialogService) ->

  ctrl = @
  ctrl.files = {}
  ctrl.top = {}
  ctrl.bottom = {}
  ctrl.specific = {}
  ctrl.apertures = {}

  progress = progressService $scope, "orderCtrl", "specificCtrl"

  ctrl.ifInvalid = ->
    if ctrl.invalid then simpleDialogService {}, "title-add-paste-layer"
    ctrl.invalid

  ctrl.back = -> progress no

  ctrl.next = -> if not ctrl.ifInvalid() then progress yes

  ctrl

controller.$inject = ["$scope", "progressService", "simpleDialogService"]

module.exports = controller
