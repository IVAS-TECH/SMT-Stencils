module.exports = (stateSwitcherService) ->
  run = @
  run.$inject = ["stateSwitcherService"]
  stateSwitcher = stateSwitcherService()
  stateSwitcher.switchState stateSwitcher.child[0]
