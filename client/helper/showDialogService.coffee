module.exports = ($mdDialog, showErrorService, template) ->
  @$inject = ["$mdDialog", "showErrorService", "template"]

  (event, action, locals, handle = {}, extend) ->

    locals.hide = $mdDialog.hide

    locals.error = showErrorService

    if extend
      handle[key] = value for key, value of extend

    $mdDialog
      .show
        template: template "#{action}View"
        targetEvent: if event.target? then event else undefined
        controller: "#{action}Controller"
        controllerAs: "#{action}Ctrl"
        bindToController: yes
        locals: locals
        openFrom: "body"
        closeFrom: "body"
        escapeToClose: no
      .then (val) ->

        if typeof val is "object"
          for key, value of val
            if handle[key]? then handle[key] value
          return

        else if handle[val]? then handle[val]()
