module.exports = ($state) ->
  @$inject = ["$state"]

  toHome: -> $state.go "home.about"

  toAdmin: -> $state.go "home.admin"
