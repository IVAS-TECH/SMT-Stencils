module.exports = ($scope, $state) ->
  @$inject = ["$scope", "$state"]

  controller = @

  init = ->

    last = (stateName) ->
      name = stateName.split "\."
      name[name.length - 1]

    highlight = (state) ->
      index = controller.states.indexOf state
      if index > -1
        controller.selected = (false for [1..controller.states.length])
        controller.selected[index] = true

    allStates = $state.get()

    if not controller.override? then controller.override = {}
    if not controller.remove? then controller.remove = []

    addIfDirectChild = (s) ->
      if not s.abstract and s.name isnt controller.state and s.name.match controller.state
        name = if controller.state then s.name.replace "#{controller.state}.", "" else s.name
        if name not in controller.remove and not name.match /\./ then return name

    controller.states = (addIfDirectChild state for state in allStates).filter (e) -> e?

    highlight last $state.current.name

    $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) ->
      state = last toState.name
      highlight state
      if controller.override[state]?
        $state.go [controller.state, state, controller.override[state]].join "\."

  controller.switchState = (state) ->
      $state.go "#{controller.state}.#{state}"

  init()

  controller
