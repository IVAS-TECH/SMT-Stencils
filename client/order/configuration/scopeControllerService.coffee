service = ->

  (scope) ->

    findAndAssign = (current) ->
      for key, value of current
        if key is scope.controller and typeof value is "object"
          scope["scopeCtrl"] = value
          return yes
      return no

    search = scope

    while not findAndAssign search
      if search.$parent?
        search = search.$parent
      else break

service.$inject = []

module.exports = service
