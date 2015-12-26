module.exports = (template, $state) ->
  @$inject = ["template", "$state", "$location"]

  template: template "stateSwitcherView"
  scope: true
  controller: ->
  controllerAs: "stateSwitcherCtrl"
  bindToController:
    state: "@"
    menu: "@"
  link: (scope, element, attrs, controller) ->

    highlight = (state) ->
      controller.selected = controller.select controller.states.indexOf state

    init = ->

      allStates = $state.get()
      test = new RegExp controller.state

      addIfDirectChild = (s) ->
        if not s.abstract and s.name isnt controller.state and s.name.match test
          name = if controller.state then s.name.replace "#{controller.state}.", "" else s.name
          if not name.match /\./ then return name

      controller.states = (addIfDirectChild state for state in allStates).filter (e) -> e?

      checkStates = (current) ->
        isState = (state) ->
          test = new RegExp state
          if current.name.match test then highlight state
        isState state for state in controller.states

      checkStates  $state.current

      scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) ->
        checkStates toState

    controller.select = (i = 0) ->
        select = (false for [1..controller.states.length])
        select[i] = true
        select

    controller.switchState = (state) ->
      $state.go "#{controller.state}.#{state}"

    init()
