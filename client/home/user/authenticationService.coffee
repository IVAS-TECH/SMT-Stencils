{angular} = require "dependencies"
Promise = require "promise"

module.exports = (RESTHelperService, $rootScope, $state) ->
  @$inject = ["RESTHelperService", "$rootScope", "$state"]

  _authenticated = false
  _user = null
  _session = true
  _async = false
  _admin = null

  isAdmin = -> _admin.admin

  $rootScope.$on "authentication", (event, authentication) ->
    _authenticated = true
    _user = authentication.user
    _session = authentication.session ? true
    _async = authentication.async_ ? false
    _admin = authentication.admin
    if isAdmin() then $state.go "home.admin"

  $rootScope.$on "unauthentication", (event) ->
    _authenticated = false
    _user = null
    _session = true
    _async = true
    _admin = false

  authenticate: (authentication) ->
    broadcast = (auth) ->
      $rootScope.$broadcast "authentication", auth

    if authentication? then broadcast authentication
    else
      new Promise (resolve, reject) ->
        RESTHelperService.logged (res) ->
          res.async_ = true
          if res.login then broadcast res
          resolve()

  unauthenticate: (callback) ->
    RESTHelperService.logout ->
      $rootScope.$broadcast "unauthentication"
      callback()

  getUser: -> _user

  getAdminInfo: -> if _admin then _admin else {}

  isAuthenticated: -> _authenticated

  isSession: -> _session

  isAsync: -> _async

  isAdmin: isAdmin
