controller = ($scope, $state, statesForStateService) ->

  ctrl = @
  separator = "."

  init = ->
    ctrl.states = statesForStateService ctrl.state, ctrl.remove

    override = (event, toState, toParams, fromState, fromParams) ->
      current = toState.name
      console.log current
      ctrl.selected = ((current.match state + "(?!s)")? for state in ctrl.states)
      if ctrl.override?
        name = current.split separator
        check = name[name.length - 1]
        override = ctrl.override[check]
        if override? then $state.go [ctrl.state, check, override].join separator

    override null, $state.current

    stop = $scope.$on "$stateChangeSuccess", override

    $scope.$on "$destroy", ->
        console.log "DESTROY"
        stop()

  ctrl.switchState = (state) -> $state.go ctrl.state + separator + state

  init()

  ctrl

controller.$inject = ["$scope", "$state", "statesForStateService"]

module.exports = controller
