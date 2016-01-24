module.exports = ($translate, $scope, RESTHelperService, authenticationService) ->
  @$inject = ["$translate", "$scope", "RESTHelperService", "authenticationService"]

  controller = @

  controller.languages = ["bg", "en"]

  controller.current = $translate.use()

  init = ->

    getLanguage = ->
      RESTHelperService.language.get (res) ->
        if res.language?
          controller.current = res.language
          controller.change controller.current
          $scope.$digest()

    if authenticationService.isAuthenticated()
      getLanguage()

    stop = $scope.$on "authentication", getLanguage

    $scope.$on "$destroy", stop

  controller.change = (len) ->
    $translate.use len
    if authenticationService.isAuthenticated()
      RESTHelperService.language.set language: len, (res) ->

  init()

  controller
