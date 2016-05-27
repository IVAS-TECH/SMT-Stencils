service = ($mdDialog) -> (log) -> $mdDialog.show
    templateUrl: "logView"
    controller: "logController"
    controllerAs: "logCtrl"
    bindToController: yes
    escapeToClose: no
    hasBackdrop: no
    fullscreen: yes
    locals:
        hide: $mdDialog.hide
        log: log + ".log"

service.$inject = ["$mdDialog"]

module.exports = service
