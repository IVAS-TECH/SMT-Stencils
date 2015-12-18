module.exports = (RESTHelperService, $scope, $state) ->
  controller = @
  controller.$inject = ["RESTHelperService", "$scope", "$state"]
  controller.files = []
  controller.top = {}
  controller.bottom = {}

  restore = ->
    if $scope.$parent.orderCtrl.files?
      controller.files = $scope.$parent.orderCtrl.files
      controller.top = $scope.$parent.orderCtrl.top
      controller.bottom = $scope.$parent.orderCtrl.bottom

  move = (state) ->
    $scope.$parent.orderCtrl.files = controller.files
    $scope.$parent.orderCtrl.top = controller.top
    $scope.$parent.orderCtrl.bottom = controller.bottom
    $state.go "home.order.#{state}"

  controller.upload = ->
    RESTHelperService.upload.preview controller.files, (res) ->
      test = (model) -> if model? then model else undefined
      controller.top.view = test res.top
      controller.bottom.view = test res.bottom

  controller.back = -> move "configuration"

  controller.next = -> move "addresses"

  restore()

  controller
