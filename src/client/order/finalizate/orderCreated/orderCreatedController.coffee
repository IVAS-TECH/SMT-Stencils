controller = ($scope, $state) ->
    ctrl = @

    ctrl.notNow = ->
        ctrl.hide "notNow"
        $scope.$emit "transition-from-order"
        $state.go "home.orders"

    ctrl

controller.$inject = ["$scope", "$state"]

module.exports = controller
