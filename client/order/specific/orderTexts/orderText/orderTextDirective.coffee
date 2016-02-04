directive = (template) ->

  template: template "orderTextView"
  scope: yes
  controller: ->
  controllerAs: "orderTextCtrl"
  bindToController:
    text: "="
    label: "="
    disabled: "="
  link: (scope, element, attrs, controller) ->
    if not controller.text?
      controller.text = [""]

directive.$inject = ["template"]

module.exports = directive
