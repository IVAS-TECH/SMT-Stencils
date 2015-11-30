module.exports = ($state, authenticationService) ->
  run = @
  run.$inject = ["$state", "authenticationService"]
  authenticationService.authenticate().then ->
