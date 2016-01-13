Promise = require "promise"

module.exports = ($scope, RESTHelperService, simpleDialogService, progressService, link) ->
  @$inject = ["$scope", "RESTHelperService", "simpleDialogService", "progressService", "link"]

  controller = @

  controller.link = link

  controller.controller = "baseCtrl"

  controller.common = ["Object", "List", "Index", "Action", "Disabled"]

  controller.getObjects = ->
    list = controller.link + controller.common[1]
    RESTHelperService[controller.link].find (res) ->
        controller[list] = res[list]

  controller.reset = ->
    controller[controller.link + controller.common[4]] = no
    controller[controller.link + controller.common[3]] = "create"
    delete controller[controller.link + controller.common[2]]
    controller[controller.link + controller.common[0]] = {}
    controller.change()

  controller.change = ->

  controller.choose = ->
    controller[controller.link + controller.common[4]] = yes
    controller[controller.link + controller.common[3]] = "preview"
    index = controller[controller.link + controller.common[2]]
    controller[controller.link + controller.common[0]] = controller[controller.link + controller.common[1]][index]
    controller.change()

  controller.save = ->
    new Promise (resolve, reject) ->
      RESTHelperService[controller.link]
        .create "#{controller.link}": controller[controller.link + controller.common[0]], (res) ->
          resolve()

  properties = (controller.link + prop for prop in controller.common)

  progress = progressService $scope, "orderCtrl", controller.controller, ["link"], properties

  controller.restore = ->
    if not $scope.$parent.orderCtrl[controller.link + controller.common[0]]?
      controller.getObjects()
    else
      stop = $scope.$on "update-view", ->
        controller.choose()
        stop()

  controller.next = (event) ->
    if (controller.valid.every (element) -> element is yes)
      if controller.saveIt
        controller.save().then ->
          progress yes
      else progress yes
    else simpleDialogService event, "required-fields"

  controller
