controller = ($scope, progressService, simpleDialogService) ->

  ctrl = @
  ctrl.files = {}
  ctrl.top = {}
  ctrl.bottom = {}
  ctrl.specific = {}
  ctrl.apertures = {}

  progress = progressService $scope, "specificCtrl"

  ctrl.ifInvalid = ->
    if ctrl.invalid then simpleDialogService {}, "title-add-needed-layers"
    ctrl.invalid

  ctrl.next = -> if not ctrl.ifInvalid() then progress.next()

  ctrl.back = progress.back

  ctrl

controller.$inject = ["$scope", "progressService", "simpleDialogService"]

module.exports = controller
