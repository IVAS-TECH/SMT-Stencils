Controller.$inject = ['$rootScope', 'Restangular', '$location', 'AppShowToast'];

function Controller($rootScope, Restangular, $location, AppShowToast) {
  var vm = this;
  vm.doLogOut = doLogOut;

  function doLogOut() {
    var msg = ' You have beed Log Outed!',
      logouted = $rootScope.user + msg;
    Restangular.one('logout');
    delete $rootScope.user;
    AppShowToast(logouted, 'bottom right');
    $location.path('/login');
  }
}

export var Controller = Controller;
