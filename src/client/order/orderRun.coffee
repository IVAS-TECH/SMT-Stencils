run = ($rootScope, $state, transitionFromOrderService) ->
    show = yes
    stopGuarding = $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
        isTo = not (toState.name.match /home\.order/)? or toState.name is "home.orders"
        isFrom = (fromState.name.match /home\.order\./)?
        if isTo and isFrom and show
            event.preventDefault()
            transitionFromOrderService {}, "continue": ->
                show = no
                $state.go toState, {}, reload: yes
        if show is no then show = yes
    stopBuypassing = $rootScope.$on "transition-from-order", -> show = no
    $rootScope.$on "$destroy", ->
        stopGuarding()
        stopBuypassing()

run.$inject = ["$rootScope", "$state", "transitionFromOrderService"]

module.exports = run
