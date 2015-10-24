Controller.$inject = ['$rootScope', 'Restangular', '$location'];

function Controller($rootScope, Restangular, $location) {
  var vm = this,
    prop = 'user';
  vm.user = $rootScope.user;
  vm.loggedIn = !$rootScope.hasOwnProperty(prop);
  vm.doLogOut = doLogOut;

  $rootScope.$watch(prop, loggedIn);

  function loggedIn(newValue) {
    if(newValue) {
      vm.loggedIn = true;
      vm.user = newValue;
    }
    else
      vm.loggedIn = false;

  }

  function doLogOut() {
    Restangular.one('logout');
    delete $rootScope.user;
    $rootScope.logout = vm.user + ' You have beed Log Outed!';
    $location.path('/login');
  }
}

export var Controller = Controller;
