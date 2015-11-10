Controller.$inject = ['Restangular', '$rootScope', '$mdDialog'];

var controllerName = 'dialogLogInController';
var dialogLogInController = {};

function Controller(Restangular, $rootScope, $mdDialog) {
    var vm = this;
    vm.login = {};
    vm.login.email;
    vm.login.password;
    vm.session = true;
    vm.reqCheckLogin = false;
    vm.doLogIn = doLogIn;
    vm.close = close;
    vm.error = false;

    function doLogIn(valid) {
        if(!vm.reqCheckLogin)
            vm.reqCheckLogin = true;
        if(valid) {
            var login = {};
            var restLogin = Restangular.all('login');
            login.user = vm.login;
            login.session = vm.session;
            restLogin.post(login).then(success);
        }
        else
          showError("Please make sure all fields are valid!");

        function success(res) {
            if (res.success) {
                vm.notLoggedIn = false;
                $rootScope.user = login.user;
                close();
            }
            else
              showError("Wrong Email or Password!");
        }
    }

    function close(val) {
      $mdDialog.hide(val);
    }

    function showError(msg) {
      vm.error = true;
      vm.msg = msg
    }
}

dialogLogInController.controllerName = controllerName;
dialogLogInController.controller = Controller;

export var dialogLogInController = dialogLogInController;
