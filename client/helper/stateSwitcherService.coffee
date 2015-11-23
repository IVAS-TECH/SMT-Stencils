StateSwitcher = require "./StateSwitcher"

module.exports = ($state) ->
  service = @
  service.$inject = ["$state"]
  closureStateSwitcher = StateSwitcher $state.go
  newStateSwitcher = (state) ->
    current = state.current.name
    allStates = state.get()
    children = []
    addIfDirectChild = (s) ->
      if not s.abstract and s.name isnt current
        name = s.name.replace "#{current}.", ""
        if not name.match /\./ then children.push name
    addIfDirectChild state for state in allStates
    closureStateSwitcher current, children
  -> newStateSwitcher $state
