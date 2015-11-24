module.exports = (stateSwitcherService) ->
  stateSwitcher = stateSwitcherService()
  root = @
  root.$inject = ["stateSwitcherService"]
  root.states = stateSwitcher.child
  root.selected = stateSwitcher.select()
  root.switchState = (state) ->
    index = root.states.indexOf state
    root.selected = stateSwitcher.select(index)
    stateSwitcher.switchState root.states[index]
  root
