module.exports = ($state) ->
  @$inject = ["$state"]

  -> $state.go "home.admin"