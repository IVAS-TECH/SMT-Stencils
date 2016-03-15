service = ($rootScope, $state) ->

  running = yes

  stop = ->
    running = no
    $rootScope.$broadcast "cancel-loading"

  (state) -> if running and ($state.current.name.match state)? then stop()

service.$inject = ["$rootScope", "$state"]

module.exports = service
