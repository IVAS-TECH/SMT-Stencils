service = ($mdDialog) ->

  (event, dialog, locals, handle = {}, extend) ->

    locals.hide = $mdDialog.hide

    if extend? then handle[key] = value for key, value of extend

    $mdDialog
      .show
        templateUrl: "#{dialog}View"
        targetEvent: if event.target? then event else undefined
        controller: "#{dialog}Controller"
        controllerAs: "#{dialog}Ctrl"
        bindToController: yes
        locals: locals
        openFrom: "body"
        closeFrom: "body"
        escapeToClose: no
      .then (reason) ->

        if typeof reason is "object"
          for key, value of reason
            if handle[key]? then handle[key] value
          return

        else if handle[reason]? then handle[reason]()

service.$inject = ["$mdDialog"]

module.exports = service
