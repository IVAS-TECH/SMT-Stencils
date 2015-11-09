Controller.$inject = ['$mdDialog'];

var controllerName = 'directiveAppLogInController';
var directiveAppLogInController = {};

function Controller($mdDialog) {
    var vm = this;
    vm.showLogIn = showLogIn;

    function showLogIn(event) {
      var dialog = {};
      dialog.templateUrl = 'dialog-app-log-in';
      dialog.targetEvent = event;
      dialog.clickOutsideToClose = true;
      //dialog.controller = 'templateConfirmAccessController';
      //dialog.controllerAs = 'vm';

      $mdDialog.show(dialog);
    }

    function showRegister() {

    }
}

directiveAppLogInController.controllerName = controllerName;
directiveAppLogInController.controller = Controller;

export var directiveAppLogInController = directiveAppLogInController;
