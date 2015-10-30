Controller.$inject = ['$rootScope', 'Restangular', '$state', 'AppShowDialog'];

var controllerName = 'directiveAppLogOutController',
  directiveAppLogOutController = {};

function Controller($rootScope, Restangular, $state, AppShowDialog) {
  var vm = this;
  vm.doLogOut = doLogOut;

  function doLogOut() {
    var msg = ' You have beed Log Outed!',
      logouted = $rootScope.user.email + msg,
      rest = Restangular.all('logout'),
      reset = {};
    rest.get('');
    delete $rootScope.user;
    reset.reload = true;
    reset.ignoreDsr = true;
    $state.go('home', {} , reset);
    AppShowDialog(logouted);
  }
}

directiveAppLogOutController.controllerName = controllerName;
directiveAppLogOutController.controller = Controller;

export var directiveAppLogOutController = directiveAppLogOutController;
