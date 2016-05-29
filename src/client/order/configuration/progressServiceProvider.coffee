provider = ->

  parentState = ""

  service = ($state, statesForStateService) ->
    separator = "."
    parent = $state.get parentState
    move = statesForStateService parentState

    (scope, current, exclude = [], awaiting = []) ->
      state = $state.current.name.replace parentState + separator, ""
      currentScope = parentScope = properties = null

      if scope? then restored = scope.$watch current, (controller) ->
        currentScope = scope[current]
        parentScope = scope.$parent[(parent.controller.split " as ")[1]]

        properties = (Object.keys currentScope).filter (property) ->
          typeof currentScope[property] isnt "function" and property not in exclude
        properties.push deferred for deferred in awaiting

        if ((parentScope[property]? for property in properties).every (e) -> e is yes) 
          currentScope[property] = parentScope[property] for property in properties
          scope.$emit "update-view"
        restored()

      progress = (forward) ->
        if scope? then parentScope[property] = currentScope[property] for property in properties
        $state.go parentState + separator + move[(move.indexOf state) + if forward then 1 else -1]

      next: -> progress yes

      back: -> progress no

  service.$inject = ["$state", "statesForStateService"]

  setState: (state) -> parentState = state

  $get: service

provider.$inject = []

module.exports = provider
