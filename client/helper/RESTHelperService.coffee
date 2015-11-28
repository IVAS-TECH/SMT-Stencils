resolve = (resolver) -> (res) -> resolver res.data

module.exports = (REST) ->
  factory = @
  factory.$inject = ["REST"]
  loginREST = REST.make "login"
  userREST = REST.make "user"
  factory.email = (email, resolver) -> userREST.get(email).then resolve resolver
  factory.register = (user, resolver) -> userREST.post(user).then resolve resolver
  factory.loged = (resolver) -> loginREST.get().then resolve resolver
  factory.login = (user, resolver) -> loginREST.post(user).then resolve resolver
  factory.logout = (resolver) -> loginREST.delete().then resolve resolver
  factory.profile = (change, resolver) -> userREST.patch(change).then resolve resolver
  factory
