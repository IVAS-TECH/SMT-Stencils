module.exports = (template) ->
  directive = @
  directive.$inject = ["template"]
  template: template "translateView"
  controller: "translateController"
  controllerAs: "translateCtrl"
