provider = ->

  fromState = ""

  service = ($state, statesForStateService) ->
    separator = "."
    parent = $state.get fromState
    move = statesForStateService fromState

    (scope, current, exclude = [], awaiting = []) ->
      state = $state.current.name.replace fromState + separator, ""
      currentScope = parentScope = properties = null

      if scope? then restored = scope.$watch current, (controller) ->
        currentScope = scope[current]
        parentScope = scope.$parent[(parent.controller.split " as ")[1]]

        properties = (Object.keys currentScope).filter (property) ->
          property isnt "$inject" and typeof currentScope[property] isnt "function" and property not in exclude
        properties.push deferred for deferred in awaiting

        if parentScope[properties[0]]?
          currentScope[property] = parentScope[property] for property in properties
          scope.$emit "update-view"
        restored()

      (progress) ->
        if scope? then parentScope[property] = currentScope[property] for property in properties
        $state.go fromState + separator + move[(move.indexOf state) + if progress then 1 else -1]

  service.$inject = ["$state", "statesForStateService"]

  setState: (state) -> fromState = state

  $get: service

provider.$inject = []

module.exports = provider
