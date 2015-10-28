Controller.$inject = ['Restangular', '$state', '$rootScope', 'AppShowDialog'];

function Controller(Restangular, $state, $rootScope, AppShowDialog) {
    var vm = this,
      prop = 'user',
      state = 'user.home',
      pos = 'top right';
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
                $rootScope[prop] = login.user.email;
                $state.go(state);
            }
            else
              AppShowDialog('Wrong email or password', pos);
        }
    }
}

export var Controller = Controller;
