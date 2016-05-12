controller = ($scope, $state, statesForStateService) ->

  ctrl = @
  separator = "."

  init = ->
    ctrl.states = statesForStateService ctrl.state, ctrl.remove

    override = (event, toState, toParams, fromState, fromParams) ->
      current = toState.name
      ctrl.selected = ((current.match state + "(?!s)")? for state in ctrl.states)
      if ctrl.override?
        name = current.split separator
        check = name[name.length - 1]
        change = ctrl.override[check]
        if change? then $state.go [ctrl.state, check, change].join separator

    override null, $state.current

    stop = $scope.$on "$stateChangeSuccess", override

    $scope.$on "$destroy", stop

  ctrl.switchState = (state) -> $state.go ctrl.state + separator + state

  init()

  ctrl

controller.$inject = ["$scope", "$state", "statesForStateService"]

module.exports = controller
