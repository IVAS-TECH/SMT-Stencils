Promise = require "promise"

module.exports = ($scope, RESTHelperService, simpleDialogService, progressService, confirmService, link) ->
  @$inject = ["$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "link"]

  controller = @

  controller.link = link

  controller.template = link + "View"

  controller.controller = "baseCtrl"

  controller.valid = []

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

  controller.isValid = (resolve, reject) ->
    if (controller.valid.every (e) -> e is yes)
      resolve()
    else
      reject()
      simpleDialogService event, "required-fields"

  controller.save = ->
    new Promise (resolve, reject) ->
      create = ->
        save = controller[controller.link + controller.common[0]]
        RESTHelperService[controller.link].create "#{controller.link}": save, (res) ->
          controller[controller.link + controller.common[0]]._id = res.id
          resolve()
      controller.isValid create, reject

  controller.edit = ->
    controller[controller.link + controller.common[4]] = no
    controller[controller.link + controller.common[3]] = "edit"

  controller.delete = (event) ->
    controller.isValid ->
      confirmService event, success: ->
        id = controller[controller.link + controller.common[0]]._id
        RESTHelperService[controller.link].delete id, (res) ->
          controller.reset()
          $scope.$digest()

  controller.update = (event) ->
    controller.isValid ->
      confirmService event, success: ->
        update = controller[controller.link + controller.common[0]]
        RESTHelperService[controller.link].update "#{controller.link}": update, (res) ->

  controller.doAction = (event) ->
    action = controller[controller.link + controller.common[3]]
    if action is "create"
      controller.save event
    if action is "edit"
      controller.update event

  properties = (controller.link + prop for prop in controller.common)

  progress = progressService $scope, "orderCtrl", controller.controller, ["link", "template", "valid", "btnBack"], properties

  controller.restore = ->
    if not $scope.$parent.orderCtrl[controller.link + controller.common[0]]?
      controller.getObjects()
    else
      stop = $scope.$on "update-view", ->
        controller.choose()
        stop()

  controller.next = (event) ->
    if controller.saveIt
      controller.save().then -> progress yes
    else progress yes

  controller.back = -> progress no

  controller
