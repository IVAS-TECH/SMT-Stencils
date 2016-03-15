service = (circularDialogService, authenticationService) ->
    circularDialogService "login", "login", (authentication) -> authenticationService.authenticate authentication

service.$inject = ["circularDialogService", "authenticationService"]

module.exports = service
