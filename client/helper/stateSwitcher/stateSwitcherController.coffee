controller = ($scope, $state, statesForStateService) ->

  ctrl = @
  
  separator = "."

  init = ->
    if not ctrl.override? then ctrl.override = {}
    if not ctrl.remove? then ctrl.remove = []

    ctrl.states = statesForStateService ctrl.state, ctrl.remove

    override = (event, toState, toParams, fromState, fromParams) ->
      current = toState.name
      name = current.split separator
      check = name[name.length - 1]
      change = ctrl.override[check]
      ctrl.selected = (Boolean current.match state + "(?!s)" for state in ctrl.states)
      if change? then $state.go [ctrl.state, check, change].join separator

    override null, $state.current

    stop = $scope.$on "$stateChangeSuccess", override

    $scope.$on "$destroy", stop

  ctrl.switchState = (state) -> $state.go ctrl.state + separator + state

  init()

  ctrl

controller.$inject = ["$scope", "$state", "statesForStateService"]

module.exports = controller
