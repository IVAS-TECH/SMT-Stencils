function Directive () {
  var directive = {},
    url = 'view-logged-in';

  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = Controller;
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  Controller.$inject = ['$rootScope', 'Restangular', '$location'];
  function Controller($rootScope, Restangular, $location) {
    var vm = this;
    vm.user = $rootScope.user;
    vm.doLogOut = doLogOut;

    function doLogOut() {
      Restangular.one('logout');
      delete $rootScope.user;
      $rootScope.logout = vm.user + ' You have beed logouted';
      $location.path('/login');
    }
  }

  return directive;
}

var directiveName = 'appLoggedIn',
  appLoggedInDirective = {};

appLoggedInDirective.directiveName = directiveName;
appLoggedInDirective.directive = Directive;

export var appLoggedInDirective = appLoggedInDirective;
