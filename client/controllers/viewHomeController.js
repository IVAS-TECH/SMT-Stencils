Controller.$inject = ['$state', '$rootScope', 'AppShowDialog'];

var controllerName = 'viewHomeController',
  viewHomeController = {};

function Controller($state, $rootScope, AppShowDialog) {
  var vm = this,
    common = ['about', 'tech', 'contact'],
    loggedIn = ['settings.profile'],
    notLogged = [''];
  vm.btns = ['About Us', 'Technologies', 'Contact Us', 'Settings'];
  vm.click = [];
  vm.goToState = goToState;
  init($rootScope.user);

  $rootScope.$watch('user', init);

  function goToState(state) {
    if(!state) {
        AppShowDialog('Please Log in first!');
        return;
    }
    $state.go(state);
  }

  function init(check) {
    if(check)
      setOnclick(loggedIn);
    else
      setOnclick(notLogged);
  }

  function setOnclick(clicks) {
    var res = angular.copy(common);
    clicks.forEach(add);
    vm.click = res.map(makeState);

    function add(item) {
        res.push(item);
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
