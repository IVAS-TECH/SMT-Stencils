service = (showDialogService) -> (event, locals, extend) -> showDialogService event, "payWithStripes", locals, {}, extend

service.$inject = ["showDialogService"]

module.exports = service
