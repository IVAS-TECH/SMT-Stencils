controller = ($interval, RESTHelperService) ->
    ctrl = @
    subscribe = undefined
    ctrl.content = [""]

    fetch = -> RESTHelperService.log.fetch ctrl.log, (res) ->
        if typeof res is "string" then ctrl.content = res.split "\n"

    init = ->
        fetch()
        subscribe = $interval fetch, 2000

    ctrl.close = ->
        $interval.cancel subscribe
        ctrl.hide()

    init()

    ctrl

controller.$inject = ["$interval", "RESTHelperService"]

module.exports = controller
