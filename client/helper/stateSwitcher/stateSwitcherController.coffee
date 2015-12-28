module.exports = ($scope, $state) ->
  controller = @
  controller.$inject = ["$scope", "$state"]

  init = ->

    last = (stateName) ->
      name = stateName.split "\."
      name[name.length - 1]

    highlight = (state) ->
      index = controller.states.indexOf state
      if index > -1
        controller.selected = controller.select index

    allStates = $state.get()
    test = new RegExp controller.state

    if not controller.override? then controller.override = {}

    addIfDirectChild = (s) ->
      if not s.abstract and s.name isnt controller.state and s.name.match test
        name = if controller.state then s.name.replace "#{controller.state}.", "" else s.name
        if not name.match /\./ then return name

    controller.states = (addIfDirectChild state for state in allStates).filter (e) -> e?

    highlight last $state.current.name

    $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) ->
      state = last toState.name
      highlight state
      if controller.override[state]?
        $state.go "#{controller.state}.#{controller.override[state]}"

  controller.select = (i = 0) ->
      select = (false for [1..controller.states.length])
      select[i] = true
      select

  controller.switchState = (state) ->
      $state.go "#{controller.state}.#{state}"

  init()

  controller
