service = ($rootScope, $q, RESTHelperService) ->

  _authenticated = no
  _user = null
  _session = yes
  _admin = null

  authenticate: (authentication) ->

    broadcast = (auth) ->
      _authenticated = yes
      _user = auth.user
      _session = auth.session ? yes
      _admin = auth.user.admin
      $rootScope.$broadcast "authentication"

    if authentication? then broadcast authentication
    else
      $q (resolve, reject) ->
        RESTHelperService.login.logged (res) ->
          if res.login then broadcast res
          resolve()

  unauthenticate: (callback) ->
    RESTHelperService.login.logout ->
      _authenticated = no
      _user = null
      _session = yes
      _admin = null
      $rootScope.$broadcast "unauthentication"
      if callback? then callback()

  getUser: -> _user

  getAdminAccess: -> _admin

  isAuthenticated: -> _authenticated

  isSession: -> _session

  isAdmin: -> _admin > 0

service.$inject = ["$rootScope", "$q", "RESTHelperService"]

module.exports = service
