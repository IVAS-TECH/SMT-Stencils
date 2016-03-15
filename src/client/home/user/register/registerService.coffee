service = (showDialogService, loginService, RESTHelperService) ->

  (event, extend) ->

    handle = "success": -> loginService event

    showDialogService event, "register", {}, handle, extend

service.$inject = ["showDialogService", "loginService", "RESTHelperService"]

module.exports = service
