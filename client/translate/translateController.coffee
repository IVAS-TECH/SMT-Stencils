controller = ($translate, authenticationService, RESTHelperService) ->

  ctrl = @

  ctrl.languages = ["bg", "en"]

  ctrl.current = $translate.use()

  ctrl.change = (language) ->
    $translate.use language
    if authenticationService.isAuthenticated()
        RESTHelperService.user.profile id: "id", user: language: language, (res) ->

  ctrl

controller.$inject = ["$translate", "authenticationService", "RESTHelperService"]

module.exports = controller
