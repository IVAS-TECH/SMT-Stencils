controller = ($scope, progressService, simpleDialogService) ->
    ctrl = @
    ctrl.files = {}
    ctrl.top = {}
    ctrl.bottom = {}
    ctrl.specific = {}
    ctrl.apertures = {}
    specificValid = no
    ctrl.invalid  = yes
    ctrl.action = null
    progress = progressService $scope, "specificCtrl", ["action"]

    init = ->
        stop = $scope.$on "specific-validity", (event, valid) -> specificValid = valid
        $scope.$on "$destroy", stop

    ifSpecificInvalid = ->
        invalid = not specificValid
        if invalid then simpleDialogService {}, "required-fields-after-#{ctrl.action}"
        invalid

    ctrl.ifInvalid = ->
        if ctrl.invalid then simpleDialogService {}, "title-add-needed-layers-after-#{ctrl.action}"
        ctrl.invalid

    ctrl.next = -> if not ctrl.ifInvalid() and not ifSpecificInvalid() then progress.next()

    ctrl.back = progress.back

    init()

    ctrl

controller.$inject = ["$scope", "progressService", "simpleDialogService"]

module.exports = controller
