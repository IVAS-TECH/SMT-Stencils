service = ($rootScope, $q, $translate, RESTHelperService) ->

  state = {}

  reset = -> state = auth: no, user: null, session: yes, admin: 0
    
  reset()

  authenticate: (authentication) ->

    broadcast = (auth) ->
      state = auth: yes, user: auth.user, session: auth.session ? yes, admin: auth.user.admin
      $translate.use auth.user.language
      $rootScope.$broadcast "authentication"

    if authentication? then broadcast authentication
    else $q (resolve, reject) ->
      RESTHelperService.login.logged (res) ->
        if res.login then broadcast res
        resolve()

  unauthenticate: (callback) ->
    RESTHelperService.login.logout ->
      reset()
      $rootScope.$broadcast "unauthentication"
      if callback? then callback()

  getUser: -> state.user

  getAdminAccess: -> state.admin

  isAuthenticated: -> state.auth

  isSession: -> state.session

  isAdmin: -> state.admin > 0

service.$inject = ["$rootScope", "$q", "$translate", "RESTHelperService"]

module.exports = service