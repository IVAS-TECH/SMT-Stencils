module.exports = ($state) ->
  run = @
  run.$inject = ["$state"]
  $state.go "root"
