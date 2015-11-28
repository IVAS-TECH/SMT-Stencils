{angular} = require "dependencies"

module.exports = (RESTHelperService, $rootScope) ->
  @$inject = ["RESTHelperService", "$rootScope"]
  class Auth
    constructor: (@user = null, @authenticated = false) ->
    authenticate: (user) ->
      auth = angular.bind @, (user) ->
        if user
          @authenticated = true
          @user = user
        $rootScope.$broadcast "authentication"
      if user? then auth user
      else
        RESTHelperService.logged (res) ->
          if res.success then auth res.user else auth()
    unauthenticate: ->
      @authenticated = false
      @user = null
      RESTHelperService.logout ->
  auth = new Auth()
  return auth
