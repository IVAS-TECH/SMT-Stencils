Controller.$inject = ['$rootScope', 'Restangular', '$state', 'AppShowDialog'];

function Controller($rootScope, Restangular, $state, AppShowDialog) {
  var vm = this;
  vm.doLogOut = doLogOut;

  function doLogOut() {
    var msg = ' You have beed Log Outed!',
      logouted = $rootScope.user + msg;
    Restangular.one('logout');
    delete $rootScope.user;
    AppShowDialog(logouted);
    $state.go('login');
  }
}

export var Controller = Controller;
