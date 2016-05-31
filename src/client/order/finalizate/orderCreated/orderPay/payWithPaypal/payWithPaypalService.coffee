service = (showDialogService) -> (event, locals, extend) -> showDialogService event, "payWithPaypal", locals, {}, extend

service.$inject = ["showDialogService"]

module.exports = service
