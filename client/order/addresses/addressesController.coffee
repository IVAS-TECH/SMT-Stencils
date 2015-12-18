module.exports = ($scope, $state) ->
  controller = @
  controller.$inject = ["$scope", "$state"]
  controller.addresses =
    delivery: {}
    invoice: {}
    firm: {}

  restore = ->
    if $scope.$parent.orderCtrl.addresses?
      controller.addresses = $scope.$parent.orderCtrl.addresses

  move = (state) ->
    $scope.$parent.orderCtrl.addresses = controller.addresses
    $state.go "home.order.#{state}"

  controller.back = -> move "specific"

  #controller.next = -> $state.go "home.order.finalizate"

  restore()

  controller
