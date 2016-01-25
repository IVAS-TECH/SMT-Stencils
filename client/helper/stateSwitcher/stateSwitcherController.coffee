module.exports = ($scope, $state, $window) ->
  @$inject = ["$scope", "$state", "$window"]

  fromUI = no

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

    if ($window.navigator.userAgent.match /firefox/i)? and controller.state is "home"
      controller.states.push "" # Material uses canvas for md-tabs and it seems like firefox have problem with it's max length so this force it to be bigger

    override = (event, toState, toParams, fromState, fromParams) ->
      current = toState.name
      name = current.split "\."
      check = name[name.length - 1]
      change = controller.override[check]
      if not fromUI
        controller.selected = (Boolean current.match "#{state}(?!s)" for state in controller.states).indexOf yes
      if change? then $state.go [controller.state, check, change].join "\."

    stop = $scope.$on "$stateChangeSuccess", override

    $scope.$on "$destroy", stop

    override null, $state.current

  init()

  controller.switchState = (index) ->
    fromUI = yes
    controller.selected = index
    state = controller.states[index]
    $state.go "#{controller.state}.#{state}"

  controller
