controller = (serverLogs) ->
    ctrl = @
    ctrl.logs = serverLogs
    ctrl

controller.$inject = ["serverLogs"]

module.exports = controller
