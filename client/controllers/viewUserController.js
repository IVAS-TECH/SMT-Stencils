Controller.$inject = ['$scope'];

var controllerName = 'viewUserController',
  viewUserController = {};

function Controller($scope) {
  console.log($scope);
  $scope.ivo = "ivo";
  $scope.btns = ['Home', 'Settings', 'About Us', 'Technologies', 'Contatct Us'];
  $scope.state = ['home', 'settings', 'about', 'tech', 'contact'];
  $scope.state = $scope.state.map(state);

  function state(state) {
    var parent = 'user.';
    return parent + state;
  }
}

viewUserController.controllerName = controllerName;
viewUserController.controller = Controller;

export var viewUserController = viewUserController;
