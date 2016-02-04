directive = (template) ->

  template: template "fileView"
  scope: name: "="

directive.$inject = ["template"]

module.exports = directive
