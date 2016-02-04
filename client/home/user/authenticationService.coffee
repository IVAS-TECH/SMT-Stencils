Promise = require "promise"

service = ($rootScope, RESTHelperService) ->

  _authenticated = no
  _user = null
  _session = yes
  _async = no
  _admin = null

  authenticate: (authentication) ->

    broadcast = (auth) ->
      _authenticated = yes
      _user = auth.user
      _session = auth.session ? yes
      _async = auth.async_ ? no
      _admin = auth.admin
      $rootScope.$broadcast "authentication"

    if authentication? then broadcast authentication
    else
      new Promise (resolve, reject) ->
        RESTHelperService.login.logged (res) ->
          res.async_ = yes
          if res.login then broadcast res
          resolve()

  unauthenticate: (callback) ->
    RESTHelperService.login.logout ->
      _authenticated = no
      _user = null
      _session = yes
      _async = yes
      _admin = null
      $rootScope.$broadcast "unauthentication"
      if callback? then callback()

  getUser: -> _user

  getAdminAccess: ->
    if @isAdmin() then _admin.access ? -1 else -1

  isAuthenticated: -> _authenticated

  isSession: -> _session

  isAsync: -> _async

  isAdmin: -> if _admin? then _admin.admin else no

service.$inject = ["$rootScope", "RESTHelperService"]

module.exports = service
