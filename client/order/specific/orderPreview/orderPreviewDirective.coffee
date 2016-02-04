directive = (template) ->

  template: template "orderPreviewView"
  scope:
    controller: "="
    order: "="

directive.$inject = ["template"]

module.exports = directive
