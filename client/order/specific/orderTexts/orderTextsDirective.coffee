directive = (template) ->

  template: template "orderTextsView"
  scope: order: "="

directive.$inject = ["template"]

module.exports = directive
