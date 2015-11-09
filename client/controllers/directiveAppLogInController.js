Controller.$inject = ['$mdDialog'];

var controllerName = 'directiveAppLogInController';
var directiveAppLogInController = {};

function Controller($mdDialog) {
    var vm = this;
    vm.show = show;

    function show(event, action) {
      var dialog = {};
      dialog.templateUrl = action === 'login' ? 'dialog-log-in' : 'dialog-register';
      dialog.targetEvent = event;
      dialog.clickOutsideToClose = true;
      dialog.controller = action === 'login' ? 'dialogLogInController' : 'dialogRegisterController';
      dialog.controllerAs = 'vm';

      $mdDialog.show(dialog).then(close);

      function close(val) {
        if(val === 'login')
          show(event, val);
      }
    }
}

directiveAppLogInController.controllerName = controllerName;
directiveAppLogInController.controller = Controller;

export var directiveAppLogInController = directiveAppLogInController;
