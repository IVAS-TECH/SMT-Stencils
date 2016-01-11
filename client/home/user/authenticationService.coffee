Promise = require "promise"

module.exports = ($rootScope, RESTHelperService, transitionService) ->
  @$inject = ["$rootScope", "RESTHelperService", "transitionService"]

  _authenticated = false
  _user = null
  _session = true
  _async = false
  _admin = null

  isAdmin = -> if _admin? then _admin.admin else false

  $rootScope.$on "authentication", (event, authentication) ->
    _authenticated = true
    _user = authentication.user
    _session = authentication.session ? true
    _async = authentication.async_ ? false
    _admin = authentication.admin
    if isAdmin() then transitionService.toAdmin()

  $rootScope.$on "unauthentication", (event) ->
    _authenticated = false
    _user = null
    _session = true
    _async = true
    _admin = null

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
      if callback? then callback()

  getUser: -> _user

  getAdminAccess: ->
    if isAdmin() then _admin.access ? -1 else -1

  isAuthenticated: -> _authenticated

  isSession: -> _session

  isAsync: -> _async

  isAdmin: isAdmin
