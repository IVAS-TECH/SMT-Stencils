module.exports = ($scope, $state) ->
  @$inject = ["$scope", "$state"]

  controller = @

  init = ->

    allStates = $state.get()

    if not controller.override? then controller.override = {}
    if not controller.remove? then controller.remove = []

    addIfDirectChild = (s) ->
      if not s.abstract and s.name isnt controller.state and s.name.match controller.state
        name = if controller.state then s.name.replace "#{controller.state}.", "" else s.name
        if name not in controller.remove and not name.match /\./ then return name

    controller.states = (addIfDirectChild state for state in allStates).filter (e) -> e?

    override = (event, toState, toParams, fromState, fromParams) ->
      current = toState.name
      name = current.split "\."
      check = name[name.length - 1]
      change = controller.override[check]
      controller.selected = (Boolean current.match "#{state}(?!s)" for state in controller.states).indexOf yes
      if change? and current is controller.state + "\." + check
        $state.go [controller.state, check, change].join "\."

    $scope.$on "$stateChangeSuccess", override

    override null, $state.current

  init()

  controller.switchState = (state) ->
      $state.go "#{controller.state}.#{state}"

  controller
