controller = ($scope, $q, RESTHelperService, simpleDialogService, progressService, confirmService, link, settings, exclude, awaiting) ->
    ctrl = @
    ctrl.link = link
    ctrl.settings = settings
    ctrl.template = link + "PanelView"
    ctrl.controller = "baseCtrl"
    ctrl.valid = []
    ctrl[link + "Names"] = []
    ctrl[link + "Name"] = ""
    ctrl[link + "Object"] = {}
    nameValid = no

    ctrl.change = ->

    ctrl.nameValidity = (valid) -> if valid? then nameValid = valid

    ctrl.getObjects = ->
        field = link + "List"
        RESTHelperService[link].find (res) ->
            ctrl[field] = res[field]
            ctrl[link + "Names"] = (obj.name for obj in res[field])

    ctrl.reset = ->
        ctrl[link + "Disabled"] = no
        ctrl[link + "Action"] = "create"
        delete ctrl[link + "Index"]
        ctrl[link + "Object"] = {}
        ctrl.change()

    ctrl.preview = ->
        ctrl[link + "Disabled"] = yes
        ctrl[link + "Action"] = "preview"

    ctrl.choose = ->
        ctrl.preview()
        ctrl[link + "Index"] = ctrl[link + "List"].findIndex (e) -> e.name is ctrl[link + "Name"]
        ctrl[link + "Object"] = ctrl[link + "List"][ctrl[link + "Index"]]
        ctrl.change()

    ctrl.check = (value) -> value? and ctrl[link + "Name"] isnt value

    ctrl.isValid = (name, event, resolve, reject) ->
        tryToCall = (fns) -> (if fn? then fn()) for fn in fns
        checkValid = -> ctrl.valid.length and (ctrl.valid.every (e) -> e is yes)
        if checkValid() and name then tryToCall [resolve]
        else tryToCall [reject, -> simpleDialogService event, "required-fields"]

    ctrl.save = (event) -> $q (resolve, reject) ->
        create = -> RESTHelperService[link].create "#{link}": ctrl[link + "Object"], (res) ->
            ctrl[link + "Index"] = ctrl[link + "List"].length
            ctrl[link + "List"].push res
            ctrl[link + "Name"] = res.name
            ctrl[link + "Names"].push ctrl[link + "Name"]
            resolve()
        ctrl.isValid nameValid, event, create, reject

    if not ctrl.settings
        properties = (link + prop for prop in ["Object", "List", "Index", "Action", "Disabled", "Name", "Names"])
        properties.push awaitProperty for awaitProperty in awaiting
        excludeProperties = ["link", "template", "valid", "btnBack", "settings", "common", "controller"]
        excludeProperties.push excld for excld in exclude
        progress = progressService $scope, ctrl.controller, excludeProperties, properties

        ctrl.restore = ->
            if not $scope.$parent.orderCtrl[link + "Action"]? then ctrl.getObjects()
            else stop = $scope.$on "update-view", ->
                ctrl.choose()
                stop()

        ctrl.next = (event) ->
            if not ctrl[link + "Action"]? then simpleDialogService event, "choose-an-action"
            else if ctrl.saveIt and ctrl[link + "Action"] is "create" then (ctrl.save event).then progress.next
            else progress.next()

        ctrl.back = progress.back

    else
        ctrl.edit = ->
            ctrl[link + "Disabled"] = no
            ctrl[link + "Action"] = "edit"

        ctrl.delete = (event) -> confirmService event, success: ->
            RESTHelperService[link].remove ctrl[link + "Object"]._id, (res) ->
                ctrl[link + "List"].splice ctrl[link + "Index"], 1
                ctrl[link + "Names"].splice ctrl[link + "Index"], 1
                ctrl.reset()

        ctrl.update = (event) ->
            ctrl.isValid nameValid or (ctrl[link + "Name"] is ctrl[link + "Object"].name), event, ->
                confirmService event, success: ->
                    RESTHelperService[link].update "#{link}": ctrl[link + "Object"], (res) ->
                        ctrl[link + "Name"] = ctrl[link + "Object"].name
                        ctrl[link + "Names"][ctrl[link + "Index"]] = ctrl[link + "Name"]
                        ctrl.preview()

        ctrl.doAction = (event) ->
            action = ctrl[link + "Action"]
            if action is "create" then ctrl.save event
            if action is "edit" then ctrl.update event

    ctrl

controller.$inject = ["$scope", "$q", "RESTHelperService", "simpleDialogService", "progressService", "confirmService", "link", "settings", "exclude", "awaiting"]

module.exports = controller
