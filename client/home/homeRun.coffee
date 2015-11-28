module.exports = (stateSwitcherService, authenticationService, $rootScope) ->
  run = @
  run.$inject = ["stateSwitcherService", "authenticationService", "$rootScope"]
  stateSwitcher = stateSwitcherService()
  authenticationService.authenticate()
  stop = $rootScope.$on "authentication", (event) ->
    event.preventDefault()
    stateSwitcher.switchState stateSwitcher.child[0]
    stop()
