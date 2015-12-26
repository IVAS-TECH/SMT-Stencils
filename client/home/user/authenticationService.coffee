Promise = require "promise"
{angular} = require "dependencies"

module.exports = (RESTHelperService, $rootScope) ->
  @$inject = ["RESTHelperService", "$rootScope"]
  _authenticated = _user = _session = _async = null

  init = ->

    reset = ->
      _authenticated = false
      _user = null
      _session = true
      _async = false

    auth = (authentication) ->
      _authenticated = true
      _user = authentication.user
      _session = authentication.session ? true
      _async = authentication.async_ ? false

    reset()
    $rootScope.$on "authentication", (event, authentication) ->
      auth authentication
    $rootScope.$on "unauthentication", (event) ->
      reset()
      _async = true

  init()

  authenticate: (authentication) ->
    broadcast = (auth) ->
      $rootScope.$broadcast "authentication", auth

    if authentication? then broadcast authentication
    else
      new Promise (resolve, reject) ->
        RESTHelperService.logged (res) ->
          res.async_ = true
          if res.success then broadcast res
          resolve()

  unauthenticate: (callback) ->
    RESTHelperService.logout ->
      $rootScope.$broadcast "unauthentication"
      callback()

  getUser: -> _user

  isAuthenticated: -> _authenticated

  isSession: -> _session

  isAsync: -> _async
