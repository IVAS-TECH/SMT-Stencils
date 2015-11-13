Controller.$inject = ['$state', '$rootScope', 'AppShowDialog'];

var controllerName = 'viewHomeController',
  viewHomeController = {};

function Controller($state, $rootScope, AppShowDialog) {
  var vm = this,
  states  = ['about', 'tech', 'order', 'contact', 'settings.profile'];
  vm.btns = ['About Us', 'Technologies', 'Order', 'Contacts', 'Settings'];
  vm.click = [];
  vm.goToState = goToState;
  setOnclick($rootScope.user);

  $rootScope.$watch('user', setOnclick);

  function goToState(state) {
    if(!state) {
        AppShowDialog('Please Log in first!');
        return;
    }
    $state.go(state);
  }

  function setOnclick(logged) {
    var res = angular.copy(states);
    if(!logged)
      res[2] = res[4] = '';
    vm.click = res.map(makeState);
    function makeState(item) {
      var state = 'home.'
      if(item)
        return state + item;
      else
        return item;
    }
  }
}

viewHomeController.controllerName = controllerName;
viewHomeController.controller = Controller;

export var viewHomeController = viewHomeController;
