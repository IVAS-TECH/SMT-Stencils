directive = ->

  templateUrl: "orderTextView"
  scope: {}
  controller: ->
  controllerAs: "orderTextCtrl"
  bindToController:
    text: "="
    label: "="
    disabled: "="
  link: (scope, element, attrs, controller) ->
    if not controller.text? then controller.text = [""]

directive.$inject = []

module.exports = directive
