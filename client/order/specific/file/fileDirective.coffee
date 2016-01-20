module.exports = (template) ->
  @$inject = ["template"]

  template: template "fileView"
  scope:
    name: "="
