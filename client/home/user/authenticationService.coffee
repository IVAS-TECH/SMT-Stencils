Promise = require "promise"

module.exports = ($rootScope, RESTHelperService) ->
  @$inject = ["$rootScope", "RESTHelperService"]

  _authenticated = false
  _user = null
  _session = true
  _async = false
  _admin = null

  authenticate: (authentication) ->

    broadcast = (auth) ->
      _authenticated = true
      _user = auth.user
      _session = auth.session ? true
      _async = auth.async_ ? false
      _admin = auth.admin
      $rootScope.$broadcast "authentication"

    if authentication? then broadcast authentication
    else
      new Promise (resolve, reject) ->
        RESTHelperService.login.logged (res) ->
          res.async_ = true
          if res.login then broadcast res
          resolve()

  unauthenticate: (callback) ->
    RESTHelperService.login.logout ->
      _authenticated = false
      _user = null
      _session = true
      _async = true
      _admin = null
      $rootScope.$broadcast "unauthentication"
      if callback? then callback()

  getUser: -> _user

  getAdminAccess: ->
    if isAdmin() then _admin.access ? -1 else -1

  isAuthenticated: -> _authenticated

  isSession: -> _session

  isAsync: -> _async

  isAdmin: -> if _admin? then _admin.admin else false
