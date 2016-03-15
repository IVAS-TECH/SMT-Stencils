service = ($state) ->

  toHome: -> $state.go "home.about"

  toAdmin: -> $state.go "home.admin"

service.$inject = ["$state"]

module.exports = service
