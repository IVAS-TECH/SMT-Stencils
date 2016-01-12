module.exports = (circularDialogService, authenticationService) ->
  @$inject = ["circularDialogService", "authenticationService"]

  circularDialogService "login", "login", (authentication) ->
    authenticationService.authenticate authentication
