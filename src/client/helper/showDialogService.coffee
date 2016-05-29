service = ($mdDialog, $filter) ->

  (event, dialog, locals, handle = {}, extend = {}) ->
    locals.hide = $mdDialog.hide
    if extend? then handle[key] = value for own key, value of extend
    $mdDialog
      .show
        templateUrl: dialog + "View"
        targetEvent: if event.target? then event else undefined
        controller: dialog + "Controller"
        controllerAs: dialog + "Ctrl"
        bindToController: yes
        locals: locals
        openFrom: "body"
        closeFrom: "body"
        escapeToClose: no
      .then (reason) ->
        if ($filter "isntEmpty") reason
          for key, value of reason
            if handle[key]? then handle[key] value
        else if handle[reason]? then handle[reason]()

service.$inject = ["$mdDialog", "$filter"]

module.exports = service
