module.exports = (stateSwitcherService) ->
  switcher = stateSwitcherService()
  root = @
  root.$inject = ["stateSwitcherService"]
  root.states = switcher.child
  root.selected = switcher.select()
  root.switchState = (state) ->
    index = root.states.indexOf state
    root.selected = switcher.select(index)
    switcher.switch root.states[index]
  root
