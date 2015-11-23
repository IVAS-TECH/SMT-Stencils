module.exports = ($state, $rootScope) ->
  run = @
  run.$inject = ["$state"]
  $rootScope.$state = $state
  $state.go "root"
  run
