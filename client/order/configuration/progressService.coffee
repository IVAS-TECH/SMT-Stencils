Promise = require "promise"

module.exports = ($state) ->
  @$inject = ["$state"]

  (scope, parent, current, awaiting = []) ->
    currentScope = parentScope = properties = null

    restored = scope.$watch current, (controller) ->
      currentScope = scope[current]
      parentScope = scope.$parent[parent]

      properties = (Object.keys currentScope).filter (property) ->
        property isnt "$inject" and typeof currentScope[property] isnt "function"
      properties.push deferred for deferred in awaiting

      if parentScope[properties[0]]?
        for property in properties
          currentScope[property] = parentScope[property]
        scope.$emit "update-view"

      restored()

    (state) ->
      for property in properties
        parentScope[property] = currentScope[property]
      $state.go "home.order.#{state}"
