module.exports = ($mdDialog, template) ->
  @$inject = ["$mdDialog", "template"]
  openDialog = (event, action) ->
    $mdDialog.show
      template: template "#{action}View"
      targetEvent: event
      controller: "#{action}Controller"
      controllerAs: "#{action}Ctrl"
      clickOutsideToClose: true
  showDialog: (event, action, handle) ->
    openDialog event, action
      .then (val) ->
        if typeof val is "object"
          for key, value of val
            if handle[key]? then handle[key] value
        else
          if handle[val]? then handle[val]()
  extendHandle: (extend, handle) ->
    if extend then handle[key] = value for key, value of extend
    handle
