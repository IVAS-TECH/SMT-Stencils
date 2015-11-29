Promise = require "promise"
{angular} = require "dependencies"

module.exports = (RESTHelperService, $rootScope) ->
  @$inject = ["RESTHelperService", "$rootScope"]
  class Auth
    constructor: (@user = null, @authenticated = false, @session = true) ->
    authenticate: (authentication) ->
      auth = angular.bind @, (user) ->
        @authenticated = true
        @user = user
      if authentication?
        auth authentication.user
        @session = authentication.session
        $rootScope.$broadcast "authentication"
      else
        new Promise (resolve, reject) ->
          RESTHelperService.logged (res) ->
            if res.success then auth res.user
            resolve()
    unauthenticate: ->
      @authenticated = false
      @user = null
      RESTHelperService.logout() 
  new Auth()
