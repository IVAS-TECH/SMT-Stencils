module.exports = (template) ->
  @$inject = ["template"]

  template: template "orderTextsView"
  scope: order: "="
