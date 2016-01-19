module.exports = (template) ->
  @$inject = ["template"]

  template: template "filesView"
  scope:
    order: "="
    remove: "="
