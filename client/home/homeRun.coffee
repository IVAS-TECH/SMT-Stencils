module.exports = (stateSwitcherService, authenticationService, $rootScope) ->
  run = @
  run.$inject = ["stateSwitcherService", "authenticationService", "$rootScope"]
  stateSwitcher = stateSwitcherService()
  authenticationService.authenticate()
  $rootScope.$on "authentication", -> stateSwitcher.switchState stateSwitcher.child[0]
