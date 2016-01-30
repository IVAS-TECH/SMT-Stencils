module.exports = (template) ->
  @$inject = ["template"]
  
  template: template "userView"
  controller: "userController"
  controllerAs: "userCtrl"
