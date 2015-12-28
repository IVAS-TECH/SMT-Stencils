module.exports = (template) ->
  @$inject = ["template"]

  template: template "orderTextView"
  scope:
    text: "="
    label: "="
    disabled: "="
  link: (scope) -> scope.text = [""]
