service = ($filter) ->

  (scope) ->

    findAndAssign = (current) ->
      for own key, value of current
        if key is scope.controller and ($filter "isntEmpty") value then scope.scopeCtrl = value
      scope.scopeCtrl?

    search = scope

    while not findAndAssign search
        if search.$parent? then search = search.$parent else break

service.$inject = ["$filter"]

module.exports = service
