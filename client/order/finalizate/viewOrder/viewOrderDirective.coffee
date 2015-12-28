module.exports = (template) ->
  template: template "viewOrderView"
  scope:
    order: "="
    controller: "="
  link: (scope) -> scope.order.disabled = true
