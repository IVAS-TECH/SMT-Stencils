directive = ($q, RESTHelperService) ->

  restric: "A"
  require: ["ivstIsTaken", "ngModel"]
  scope: no
  controller: ->
  controllerAs: "takenCtrl"
  bindToController:
    isTaken: "@ivstIsTaken"
    shouldTest: "&"
  link: (scope, element, attrs, controller) ->
    takenCtrl = controller[0]
    ngModel = controller[1]
    ngModel.$asyncValidators["is-taken"] = (newValue) ->
      $q (resolve, reject) ->
        test = yes
        if takenCtrl.shouldTest? then test = takenCtrl.shouldTest value: newValue
        if not takenCtrl.isTaken.length or not test then resolve()
        else RESTHelperService[takenCtrl.isTaken].taken taken: newValue, (res) ->
          if res.taken then reject() else resolve()

directive.$inject = ["$q", "RESTHelperService"]

module.exports = directive
