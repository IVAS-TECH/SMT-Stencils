module.exports = (showDialogService, authenticationService, tryAgainService) ->
  @$inject = ["showDialogService", "authenticationService", "tryAgainService"]

  login = (event, extend) ->

    handle =

      "success": (authentication) ->
        authenticationService.authenticate authentication

      "fail": ->

        extendIt =
          "success": -> login event, extend

        tryAgainService event, "title-wrong-login", extendIt

    showDialogService
      .showDialog event, "login", {}, handle, extend

  login
