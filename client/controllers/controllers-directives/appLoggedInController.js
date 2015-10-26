Controller.$inject = ['$rootScope', 'Restangular', '$state', 'AppShowToast'];

function Controller($rootScope, Restangular, $state, AppShowToast) {
  var vm = this;
  vm.doLogOut = doLogOut;

  function doLogOut() {
    var msg = ' You have beed Log Outed!',
      logouted = $rootScope.user + msg;
    Restangular.one('logout');
    delete $rootScope.user;
    AppShowToast(logouted, 'bottom right');
    $state.go('login');
  }
}

export var Controller = Controller;
