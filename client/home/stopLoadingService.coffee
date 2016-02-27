service = ($rootScope, $state, $location) ->

  running = yes

  stop = ->
    running = no
    $rootScope.$broadcast "cancel-loading"
    
  check = ->
    state = $state.current.name
    path = $location.path().replace "/", ""
    res =  (state.match path)?
    console.log state, path, res
    res

  -> if running and check() then stop()

service.$inject = ["$rootScope", "$state", "$location"]

module.exports = service
