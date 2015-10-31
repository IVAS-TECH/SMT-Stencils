Controller.$inject = ['$state', '$rootScope', 'AppShowDialog'];

var controllerName = 'viewHomeController',
  viewHomeController = {};

function Controller($state, $rootScope, AppShowDialog) {
  var vm = this,
    common = ['about', 'tech', 'contact'],
    rest = ['settings.profile'];
  vm.btns = ['About Us', 'Technologies', 'Contacts', 'Settings'];
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

  function setOnclick(isLogIn) {
    var res = angular.copy(common);
    rest.forEach(add);
    vm.click = res.map(makeState);

    function add(item) {
        if(isLogIn)
          res.push(item);
        else
          res.push('');
    }

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
