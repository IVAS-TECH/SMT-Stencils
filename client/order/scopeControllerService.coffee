module.exports = ->

  (scope) ->

    findAndAssign = (current) ->
      for k, v of current
        if k is ctrl and typeof current[k] is "object"
          scope["scopeCtrl"] = current[k]
          return true
      return false

    ctrl = scope.controller
    search = scope
    while not findAndAssign search
      if search.$parent?
        search = search.$parent
      else
        break
