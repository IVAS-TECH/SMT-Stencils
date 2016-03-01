service = ($rootScope, $state, $location) ->

  running = yes

  stop = ->
    running = no
    $rootScope.$broadcast "cancel-loading"
    
  check = -> ($state.current.name.match $location.path().replace "/", "")?

  -> if running and check() then stop()

service.$inject = ["$rootScope", "$state", "$location"]

module.exports = service
