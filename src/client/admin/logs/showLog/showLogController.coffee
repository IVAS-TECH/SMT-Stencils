controller = (showLogService) ->
    ctrl = @
    ctrl.show = -> showLogService ctrl.log
    ctrl

controller.$inject = ["showLogService"]

module.exports = controller
