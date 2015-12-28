module.exports = ($scope) ->
  controller = @
  controller.$inject = ["$scope"]
  controller.bind = [""]

  index = 0
  enter = false
  last = ""

  $scope.$watch "textFieldCtrl.text", (newValue, oldValue) ->
    if newValue? and oldValue?
      if oldValue.length > newValue.length
        if enter
          controller.text += last
          index--
          enter = false
        else
          if not controller.bind[index].length
            index--
          controller.bind[index] = controller.bind[index].slice 0, -1

  controller.bindIt = (event) ->
    enter = event.keyCode is 13
    if enter
      controller.bind[++index] = ""
    else
      last = String.fromCharCode event.keyCode
      controller.bind[index] += last

  controller
