Controller.$inject = ['$rootScope', 'Restangular', '$state', 'AppShowDialog'];

function Controller($rootScope, Restangular, $state, AppShowDialog) {
  var vm = this;
  vm.doLogOut = doLogOut;

  function doLogOut() {
    var msg = ' You have beed Log Outed!',
      logouted = $rootScope.user + msg;
      Restangular
        .all('logout')
          .get('');
    delete $rootScope.user;
    $state.go('home', {} , {reload : true, ignoreDsr : true});
    AppShowDialog(logouted);
  }
}

export var Controller = Controller;
