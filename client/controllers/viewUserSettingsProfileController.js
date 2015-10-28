Controller.$inject = ['$mdDialog'];

var controllerName = 'viewUserSettingsProfileController',
  viewUserSettingsProfileController = {};

function Controller($mdDialog) {
  var vm = this;
  vm.email;
  vm.password;
  vm.lunchConfirm = lunchConfirm;

  function lunchConfirm(event, change, value) {
    var dialog = {},
      locals = {};
    locals.data = {};
    locals.data.type = change;
    locals.data.value = value;
    dialog.templateUrl = 'template-confirm-access';
    dialog.targetEvent = event;
    dialog.clickOutsideToClose = true;
    dialog.controller = 'templateConfirmAccessController';
    dialog.controllerAs = 'vm';
    dialog.locals = locals;
    dialog.bindToController = true;

    $mdDialog
      .show(dialog)
        .then(ans);

    function ans(a) {
      console.log(a);
    }

  }
}

viewUserSettingsProfileController.controllerName = controllerName;
viewUserSettingsProfileController.controller = Controller;

export var viewUserSettingsProfileController = viewUserSettingsProfileController;
