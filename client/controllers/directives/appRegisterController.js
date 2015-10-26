Controller.$inject = ['Restangular', '$rootScope', 'AppShowToast'];

function Controller(Restangular, $rootScope, AppShowToast) {
    var vm = this,
        restReg = Restangular.all('register'),
        pos = 'bottom right';
    vm.register = {};
    vm.register.email;
    vm.register.password;
    vm.repassword;
    vm.reqCheckReg = false;
    vm.exist = exist;
    vm.doRegister = doRegister;

    function doRegister(invalid) {
        vm.registered = vm.failed = false;
        if (!vm.reqCheckReg)
            vm.reqCheckReg = true;
        if (!invalid) {
            var register = {};
            register.user = vm.register;
            restReg.post(register).then(success);
        }
        else
          AppShowToast('Make sure all fields are valid', pos);

        function success(res) {
            if (!res.error) {
              AppShowToast('You have beed registered. Please Log In', pos);
              reset();
            } //else

            function reset() {
                var reseted = '';
                vm.reqCheckReg = false;
                vm.register.email = reseted;
                vm.register.password = reseted;
                vm.repassword = reseted;
            }
        }
    }

    function exist(modelValue) {
        var EMAIL_REGEXP = /^[a-z0-9!#$%&'*+\/=?^_`{|}~.-]+@[a-z0-9]([a-z0-9-]*[a-z0-9])?(\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)*$/i,
          validEmail = false;
        if(!_.isEmpty(modelValue))
          validEmail = EMAIL_REGEXP.test(modelValue);
        if(validEmail) {
          var promise = new Promise(resolver);

          function resolver(resolve, reject) {
              restReg.get(modelValue).then(success);

              function success(res) {
                  if (res.exist)
                      reject();
                  else
                      resolve();
              }
          }

          return promise;
        }
    }
}

export var Controller = Controller;
