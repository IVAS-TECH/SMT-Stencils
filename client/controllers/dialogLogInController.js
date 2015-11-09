Controller.$inject = ['Restangular', '$rootScope', 'AppShowDialog', '$mdDialog'];

var controllerName = 'dialogLogInController';
var dialogLogInController = {};

function Controller(Restangular, $rootScope, AppShowDialog, $mdDialog) {
    var vm = this;
    vm.login = {};
    vm.login.email;
    vm.login.password;
    vm.session = true;
    vm.reqCheckLogin = false;
    vm.doLogIn = doLogIn;
    vm.close = close;

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
          AppShowDialog('Please make sure all fields are valid!');

        function success(res) {
            if (res.success) {
                vm.notLoggedIn = false;
                $rootScope.user = login.user;
                close();
            }
            else
              AppShowDialog('Wrong email or password!');
        }
    }

    function close(val) {
      $mdDialog.hide(val);
    }
}

dialogLogInController.controllerName = controllerName;
dialogLogInController.controller = Controller;

export var dialogLogInController = dialogLogInController;
