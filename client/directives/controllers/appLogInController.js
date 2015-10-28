Controller.$inject = ['Restangular', '$rootScope', 'AppShowDialog'];

function Controller(Restangular, $rootScope, AppShowDialog) {
    var vm = this;
    vm.login = {};
    vm.login.email;
    vm.login.password;
    vm.reqCheckLogin = false;
    vm.doLogIn = doLogIn;

    function doLogIn(invalid) {
        if (!vm.reqCheckLogin)
            vm.reqCheckLogin = true;
        if (!invalid) {
            var login = {},
                restLogin = Restangular.all('login');
            login.user = vm.login;
            restLogin.post(login).then(success);
        }
        else
          AppShowDialog('Please make sure all fields are valid!');

        function success(res) {
            if (res.success) {
                vm.notLoggedIn = false;
                $rootScope.user = login.user.email;
            }
            else
              AppShowDialog('Wrong email or password!');
        }
    }
}

export var Controller = Controller;
