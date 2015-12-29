module.exports = (template) ->
  @$inject = ["template"]

  template: template "orderTextView"
  scope:
    text: "="
    label: "="
    disabled: "="
  link: (scope) ->
    if not scope.text?
      scope.text = [""]
