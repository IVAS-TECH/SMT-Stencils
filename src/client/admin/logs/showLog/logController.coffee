controller = ($interval, RESTHelperService) ->
    ctrl = @
    subscribe = undefined
    ctrl.content = [""]

    fetch = -> RESTHelperService.log.fetch ctrl.log, (res) ->
        if typeof res isnt "string" then res = JSON.stringify res
        ctrl.content = res.split "\n"

    init = ->
        fetch()
        subscribe = $interval fetch, 5000

    ctrl.close = ->
        $interval.cancel subscribe
        ctrl.hide()

    init()

    ctrl

controller.$inject = ["$interval", "RESTHelperService"]

module.exports = controller
