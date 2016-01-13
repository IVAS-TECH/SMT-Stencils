module.exports = ->

  fromState = ""

  move = []

  setState: (state) -> fromState = state

  setMove: (moves) -> move = moves

  $get: ($state) ->
    @$inject = ["$state"]

    (scope, parent, current, exclude = [], awaiting = []) ->

      state = $state.current.name.replace "#{fromState}.", ""

      currentScope = parentScope = properties = null

      restored = scope.$watch current, (controller) ->
        currentScope = scope[current]
        parentScope = scope.$parent[parent]

        properties = (Object.keys currentScope).filter (property) ->
          property isnt "$inject" and typeof currentScope[property] isnt "function" and property not in exclude

        properties.push deferred for deferred in awaiting

        if parentScope[properties[0]]?

          for property in properties
            currentScope[property] = parentScope[property]

          scope.$emit "update-view"

        restored()

       (progress) ->
         
        for property in properties
          parentScope[property] = currentScope[property]

        change = if progress then 1 else -1
        $state.go fromState + "\." + move[(move.indexOf state) + change]
