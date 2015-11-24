module.exports = ($state) ->
  stateSwitcher = stateSwitcherService()
  controller = @
  controller.$inject = ["$state"]
  controller.states = stateSwitcher.child
  controller.selected = stateSwitcher.select()
  controller.switchState = (state) ->
    index = controller.states.indexOf state
    controller.selected = stateSwitcher.select(index)
    stateSwitcher.switchState controller.states[index]
  controller
