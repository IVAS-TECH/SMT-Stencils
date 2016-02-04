directive = (template) ->

  template: template "filesView"
  scope:
    order: "="
    remove: "="

directive.$inject = ["template"]

module.exports = directive
