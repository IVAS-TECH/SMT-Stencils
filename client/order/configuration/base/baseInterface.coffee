Promise = require "promise"

module.exports = ($scope, RESTHelperService, simpleDialogService, progressService, confirmService, link, settings, exclude) ->
  @$inject = ["$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "link", "settings", "exclude"]

  controller = @

  controller.link = link

  controller.settings = settings

  controller.template = link + "PanelView"

  controller.controller = "baseCtrl"

  controller.valid = []

  controller.common = ["Object", "List", "Index", "Action", "Disabled"]

  controller[controller.link + controller.common[0]] = {}

  controller.change = ->

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

  controller.preview = ->
    controller[controller.link + controller.common[4]] = yes
    controller[controller.link + controller.common[3]] = "preview"

  controller.choose = ->
    controller.preview()
    index = controller[controller.link + controller.common[2]]
    controller[controller.link + controller.common[0]] = controller[controller.link + controller.common[1]][index]
    controller.change()

  controller.isValid = (event, resolve, reject) ->
    validForm = (controller.valid.every (e) -> e is yes)
    if validForm and controller[controller.link + controller.common[0]].name
      resolve()
    else
      reject()
      simpleDialogService event, "required-fields"

  controller.save = (event) ->
    new Promise (resolve, reject) ->
      create = ->
        save = controller[controller.link + controller.common[0]]
        RESTHelperService[controller.link].create "#{controller.link}": save, (res) ->
          index = controller[controller.link + controller.common[1]].length
          controller[controller.link + controller.common[1]].push save
          controller[controller.link + controller.common[2]] = index
          resolve()
      controller.isValid event, create, reject

  if not controller.settings

    properties = (controller.link + prop for prop in controller.common)

    excludeProperties = ["link", "template", "valid", "btnBack", "settings", "common", "controller"]

    excludeProperties.push excld for excld in exclude

    progress = progressService $scope, "orderCtrl", controller.controller, excludeProperties, properties

    controller.restore = ->
      if not $scope.$parent.orderCtrl[controller.link + controller.common[0]]?
        controller.getObjects()
      else
        stop = $scope.$on "update-view", ->
          controller.choose()
          stop()

    controller.next = (event) ->
      if controller.saveIt and controller[controller.link + controller.common[3]] is "create"
        controller.save(event).then -> progress yes
      else progress yes

    controller.back = -> progress no

  else

    controller.edit = ->
      controller[controller.link + controller.common[4]] = no
      controller[controller.link + controller.common[3]] = "edit"

    controller.delete = (event) ->
      confirmService event, success: ->
        id = controller[controller.link + controller.common[0]]._id
        RESTHelperService[controller.link].remove id, (res) ->
          controller[controller.link + controller.common[1]]
            .splice  controller[controller.link + controller.common[2]], 1
          controller.reset()
          $scope.$digest()

    controller.update = (event) ->
      controller.isValid event, ->
        confirmService event, success: ->
          update = controller[controller.link + controller.common[0]]
          RESTHelperService[controller.link].update "#{controller.link}": update, (res) ->
            controller.preview()
            $scope.$digest()

    controller.doAction = (event) ->
      action = controller[controller.link + controller.common[3]]
      if action is "create"
        controller.save event
      if action is "edit"
        controller.update event

  controller
