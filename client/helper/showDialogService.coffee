module.exports = ($mdDialog, template) ->
  @$inject = ["$mdDialog", "template"]
  openDialog = (event, action, locals = {}) ->
    locals.hide = $mdDialog.hide
    $mdDialog.show
      template: template "#{action}View"
      targetEvent: event
      controller: "#{action}Controller"
      controllerAs: "#{action}Ctrl"
      clickOutsideToClose: true
      bindToController: true
      locals: locals
      openFrom: "body"
      closeFrom: "body"
  showDialog: (event, action, handle, locals) ->
    openDialog event, action, locals
      .then (val) ->
        if typeof val is "object"
          for key, value of val
            if handle[key]? then handle[key] value
        else
          if handle[val]? then handle[val]()
  extendHandle: (extend, handle) ->
    if extend then handle[key] = value for key, value of extend
    handle
