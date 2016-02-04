Promise = require "promise"

controller = ($scope, RESTHelperService, simpleDialogService, progressService, confirmService, link, settings, exclude) ->

  ctrl = @

  ctrl.link = link

  ctrl.settings = settings

  ctrl.template = link + "PanelView"

  ctrl.controller = "baseCtrl"

  ctrl.valid = []

  ctrl.common = ["Object", "List", "Index", "Action", "Disabled"]

  ctrl[ctrl.link + ctrl.common[0]] = {}

  ctrl.change = ->

  ctrl.getObjects = ->
    list = ctrl.link + ctrl.common[1]
    RESTHelperService[ctrl.link].find (res) ->
        ctrl[list] = res[list]

  ctrl.reset = ->
    ctrl[ctrl.link + ctrl.common[4]] = no
    ctrl[ctrl.link + ctrl.common[3]] = "create"
    delete ctrl[ctrl.link + ctrl.common[2]]
    ctrl[ctrl.link + ctrl.common[0]] = {}
    ctrl.change()

  ctrl.preview = ->
    ctrl[ctrl.link + ctrl.common[4]] = yes
    ctrl[ctrl.link + ctrl.common[3]] = "preview"

  ctrl.choose = ->
    ctrl.preview()
    index = ctrl[ctrl.link + ctrl.common[2]]
    ctrl[ctrl.link + ctrl.common[0]] = ctrl[ctrl.link + ctrl.common[1]][index]
    ctrl.change()

  ctrl.isValid = (event, resolve, reject) ->
    validForm = (ctrl.valid.every (e) -> e is yes)
    if validForm and ctrl[ctrl.link + ctrl.common[0]].name
      resolve()
    else
      reject()
      simpleDialogService event, "required-fields"

  ctrl.save = (event) ->
    new Promise (resolve, reject) ->
      create = ->
        save = ctrl[ctrl.link + ctrl.common[0]]
        RESTHelperService[ctrl.link].create "#{ctrl.link}": save, (res) ->
          index = ctrl[ctrl.link + ctrl.common[1]].length
          ctrl[ctrl.link + ctrl.common[1]].push save
          ctrl[ctrl.link + ctrl.common[2]] = index
          resolve()
      ctrl.isValid event, create, reject

  if not ctrl.settings

    properties = (ctrl.link + prop for prop in ctrl.common)

    excludeProperties = ["link", "template", "valid", "btnBack", "settings", "common", "controller"]

    excludeProperties.push excld for excld in exclude

    progress = progressService $scope, "orderCtrl", ctrl.ctrl, excludeProperties, properties

    ctrl.restore = ->
      if not $scope.$parent.orderCtrl[ctrl.link + ctrl.common[0]]?
        ctrl.getObjects()
      else
        stop = $scope.$on "update-view", ->
          ctrl.choose()
          stop()

    ctrl.next = (event) ->
      if ctrl.saveIt and ctrl[ctrl.link + ctrl.common[3]] is "create"
        ctrl.save(event).then -> progress yes
      else progress yes

    ctrl.back = -> progress no

  else

    ctrl.edit = ->
      ctrl[ctrl.link + ctrl.common[4]] = no
      ctrl[ctrl.link + ctrl.common[3]] = "edit"

    ctrl.delete = (event) ->
      confirmService event, success: ->
        id = ctrl[ctrl.link + ctrl.common[0]]._id
        RESTHelperService[ctrl.link].remove id, (res) ->
          ctrl[ctrl.link + ctrl.common[1]]
            .splice  ctrl[ctrl.link + ctrl.common[2]], 1
          ctrl.reset()
          $scope.$digest()

    ctrl.update = (event) ->
      ctrl.isValid event, ->
        confirmService event, success: ->
          update = ctrl[ctrl.link + ctrl.common[0]]
          RESTHelperService[ctrl.link].update "#{ctrl.link}": update, (res) ->
            ctrl.preview()
            $scope.$digest()

    ctrl.doAction = (event) ->
      action = ctrl[ctrl.link + ctrl.common[3]]
      if action is "create"
        ctrl.save event
      if action is "edit"
        ctrl.update event

  ctrl

controller.$inject = ["$scope", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "link", "settings", "exclude"]

module.exports = controller
