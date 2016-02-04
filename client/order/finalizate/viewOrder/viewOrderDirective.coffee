directive = (template) ->

  template: template "viewOrderView"
  scope:
    order: "="
    controller: "="

  link: (scope) ->
    scope.order.disabled = true

directive.$inject = ["template"]

module.exports = directive
