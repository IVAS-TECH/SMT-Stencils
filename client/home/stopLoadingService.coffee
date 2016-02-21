service = ($rootScope, $state) ->

  running = yes

  stop = ->
    running = no
    $rootScope.$broadcast "cancel-loading"

  (ctrl) -> if running and ($state.current.name.match ctrl)? then stop()

service.$inject = ["$rootScope", "$state"]

module.exports = service
