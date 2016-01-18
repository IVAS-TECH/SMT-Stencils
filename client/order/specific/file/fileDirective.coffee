module.exports = (template) ->
  @$inject = ["template"]
  
  scope:
    name: "="
  template: template "fileView"
