StateSwitcher = require "./StateSwitcher"

module.exports = ($state) ->
  service = @
  service.$inject = ["$state"]
  closureStateSwitcher = StateSwitcher $state.go
  newStateSwitcher = (state) ->
    current = state.current.name
    allStates = state.get()
    children = []
    addIfChild = (s) ->
      if not s.abstract and s.name isnt current
        name = s.name.replace "#{current}.", ""
        final = name.split "."
        if final.length is 1 then children.push final[0]
    addIfChild state for state in allStates
    closureStateSwitcher current, children
  -> newStateSwitcher $state
