directive = ->

  templateUrl: "viewOrderView"
  scope:
    order: "="
    controller: "="

  link: (scope) ->
    scope.order.disabled = true

directive.$inject = []

module.exports = directive
