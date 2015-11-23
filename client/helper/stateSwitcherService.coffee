class StateSwitcher
  constructor: (@parent, @child) ->
  switch: (child) -> $state.go "#{@parent}.#{child}"
  select: (i = 0) ->
    select = (false for [0..@child.length])
    select[i] = true
    select

module.exports = ($state) ->
  service = @
  service.$inject = ["$state"]
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
    new StateSwitcher current, children
  -> newStateSwitcher $state
