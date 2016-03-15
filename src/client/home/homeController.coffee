controller = ($scope, $state, authenticationService) ->

  ctrl = @
  
  ctrl.notFound = $state.current.url is "/notfound"

  init = ->
  
    stop = {}
    
    events = ["authentication", "unauthentication"]
  
    tryBecomeAdmin = -> ctrl.admin = authenticationService.isAdmin()
    
    stop[event] = $scope.$on event, tryBecomeAdmin for event in events
    
    $scope.$on "$destroy", -> stop[event]() for event in events

    tryBecomeAdmin()

  init()

  ctrl

controller.$inject = ["$scope", "$state", "authenticationService"]

module.exports = controller
