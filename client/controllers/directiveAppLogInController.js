Controller.$inject = ['Restangular', '$rootScope', 'AppShowDialog'];

var controllerName = 'directiveAppLogInController',
  directiveAppLogInController = {};

function Controller(Restangular, $rootScope, AppShowDialog) {
    var vm = this;
    vm.login = {};
    vm.login.email;
    vm.login.password;
    vm.session = true;
    vm.reqCheckLogin = false;
    vm.doLogIn = doLogIn;

    function doLogIn(valid) {
        if(!vm.reqCheckLogin)
            vm.reqCheckLogin = true;
        if(valid) {
            var login = {},
                restLogin = Restangular.all('login');
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
            }
            else
              AppShowDialog('Wrong email or password!');
        }
    }
}

directiveAppLogInController.controllerName = controllerName;
directiveAppLogInController.controller = Controller;

export var directiveAppLogInController = directiveAppLogInController;
