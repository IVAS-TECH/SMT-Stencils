module.exports = (REST) ->
  factory = @
  factory.$inject = ["REST"]
  login = REST.make("login")
  user = REST.make("user")
  resolve = (resolver) -> (res) -> resolver res.data
  factory.email = (email, resolver) -> user.get(email).then resolve resolver
  factory.register = (user, resolver) -> user.post(user).then resolve resolver
  factory.loged = (resolver) -> login.get().then resolve resolver
  factory.login = (user, resolver) -> login.post(user).then resolve resolver
  factory.logout = (resolver) -> login.delete().then resolve resolver
  factory.profile = (change, resolver) -> user.patch(change).then resolve resolver
  factory
