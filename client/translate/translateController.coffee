controller = ($translate, $scope, RESTHelperService, authenticationService) ->

  ctrl = @

  ctrl.languages = ["bg", "en"]

  ctrl.current = $translate.use()

  init = ->

    getLanguage = ->
      RESTHelperService.language.find "id", (res) ->
        if res.language?
          ctrl.current = res.language.language
          $translate.use ctrl.current
          $scope.$digest()

    if authenticationService.isAuthenticated()
      getLanguage()

    stop = $scope.$on "authentication", getLanguage

    $scope.$on "$destroy", stop

  ctrl.change = (language) ->
    $translate.use language
    if authenticationService.isAuthenticated()
      RESTHelperService.language.change language: language, (res) ->

  init()

  ctrl

controller.$inject = ["$translate", "$scope", "RESTHelperService", "authenticationService"]

module.exports = controller
