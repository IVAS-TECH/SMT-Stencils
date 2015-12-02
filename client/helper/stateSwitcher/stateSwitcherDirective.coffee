module.exports = (template, $state) ->
  @$inject = ["template", "$state", "$location"]
  template: template "stateSwitcherView"
  controller: ->
  controllerAs: "stateSwitcherCtrl"
  bindToController: {
    state: "@"
    lay: "@"
    menu: "@"
  }
  link: (scope, element, attrs, controller) ->
    highlight = (state) ->
      controller.selected = controller.select controller.states.indexOf state
    init = ->
      controller.states = []
      allStates = $state.get()
      test = new RegExp controller.state
      addIfDirectChild = (s) ->
        if not s.abstract and s.name isnt controller.state and s.name.match test
          name = if controller.state then s.name.replace "#{controller.state}.", "" else s.name
          if not name.match /\./ then controller.states.push name
      addIfDirectChild state for state in allStates
      checkStates = (current) ->
        name = current.name
        isState = (state) ->
          test = new RegExp state
          if name.match test then highlight state
        isState state for state in controller.states
      checkStates  $state.current
      scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) -> checkStates toState
    controller.select = (i = 0) ->
        select = (false for [1..controller.states.length])
        select[i] = true
        select
    controller.switchState = (state) -> $state.go "#{controller.state}.#{state}"
    init()
