module.exports = (stateSwitcherService) ->
  stateSwitcher = stateSwitcherService()
  home = @
  home.$inject = ["stateSwitcherService"]
  home.states = stateSwitcher.child
  home.selected = stateSwitcher.select()
  home.switchState = (state) ->
    index = home.states.indexOf state
    home.selected = stateSwitcher.select(index)
    stateSwitcher.switchState home.states[index]
  home
