module.exports = (REST) ->
  factory = @
  factory.$inject = ["REST"]
  login = REST.make("login")
  user = REST.make("user")
  factory.email = (email, resolver) -> user.get(email).then resolver
  factory.register = (user, resolver) -> user.post(user).then resolver
  factory.loged = (resolver) -> login.get().then resolver
  factory.login = (user, resolver) -> login.post(user).then resolver
  factory.logout = (resolver) -> login.delete().then resolver
  factory.profile = (change, resolver) -> user.patch(change).then resolver
  factory
