controller = ($scope, $state) ->

  ctrl = @

  init = ->

    allStates = $state.get()

    if not ctrl.override? then ctrl.override = {}
    if not ctrl.remove? then ctrl.remove = []

    addIfDirectChild = (s) ->
      if not s.abstract and s.name isnt ctrl.state and s.name.match ctrl.state
        name = if ctrl.state then s.name.replace "#{ctrl.state}.", "" else s.name
        if name not in ctrl.remove and not name.match /\./ then return name

    ctrl.states = (addIfDirectChild state for state in allStates).filter (e) -> e?

    override = (event, toState, toParams, fromState, fromParams) ->
      current = toState.name
      name = current.split "\."
      check = name[name.length - 1]
      change = ctrl.override[check]
      ctrl.selected = (Boolean current.match "#{state}(?!s)" for state in ctrl.states)
      if change? then $state.go [ctrl.state, check, change].join "\."

    override null, $state.current

    stop = $scope.$on "$stateChangeSuccess", override

    $scope.$on "$destroy", stop

  ctrl.switchState = (state) -> $state.go "#{ctrl.state}.#{state}"

  init()

  ctrl

controller.$inject = ["$scope", "$state"]

module.exports = controller
