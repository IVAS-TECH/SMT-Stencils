Controller.$inject = ['Restangular', '$location', '$rootScope'];

function Controller(Restangular, $location, $rootScope) {
    var vm = this,
      prop = 'user';
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

        function success(res) {
            if (res.success) {
                vm.notLoggedIn = false;
                $rootScope[prop] = login.user.email;
                $location.path('/app');
            } // else
        }
    }
}

export var Controller = Controller;
