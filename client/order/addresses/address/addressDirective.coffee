directive = (template) ->

  template: template "addressView"
  controller: "addressController"
  controllerAs: "addressCtrl"
  scope:
    disabled: "="
    address: "="
    name: "@"
  link: (scope, element, attrs) ->

    scope.address = scope.address ? {}

    stop = scope.$watch "addressForm.$valid", (value) ->
      scope.$emit "address-validity", scope.name, value

    scope.$on "$destroy", stop

directive.$inject = ["template"]

module.exports = directive
