Promise = require "promise"
{angular} = require "dependencies"

module.exports = (RESTHelperService, $rootScope) ->
  @$inject = ["RESTHelperService", "$rootScope"]
  authenticated = user = session = undefined
  reset = ->
    authenticated = false
    user = null
    session = true
  reset()
  authenticate: (authentication) ->
    auth = (u) ->
      authenticated = true
      user = u
    if authentication?
      auth authentication.user
      session = authentication.session
      $rootScope.$broadcast "authentication"
    else
      new Promise (resolve, reject) ->
        RESTHelperService.logged (res) ->
          if res.success then auth res.user
          resolve()
  unauthenticate: ->
    reset()
    RESTHelperService.logout -> $rootScope.$broadcast "unauthentication"
  getUser: -> user
  isAuthenticated: -> authenticated
  isSession: -> session
  sync: reset
