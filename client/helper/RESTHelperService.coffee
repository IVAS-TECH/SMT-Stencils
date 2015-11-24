module.exports = (REST) ->
  factory = @
  factory.$inject = ["REST"]
  factory.test = (resolver) -> REST.make("test").get("test").then resolver
  factory.register = (user, resolver) -> REST.make("register").post(user).then resolver
  factory
