module.exports = (stateSwitcherService, authenticationService) ->
  run = @
  run.$inject = ["stateSwitcherService", "authenticationService"]
  stateSwitcher = stateSwitcherService()
  authenticationService.authenticate().then -> stateSwitcher.switchState stateSwitcher.child[0]
