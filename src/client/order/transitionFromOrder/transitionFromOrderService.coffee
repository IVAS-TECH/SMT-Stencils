service = (showDialogService) -> (event, extend) -> showDialogService event, "transitionFromOrder", {}, {}, extend

service.$inject = ["showDialogService"]

module.exports = service
