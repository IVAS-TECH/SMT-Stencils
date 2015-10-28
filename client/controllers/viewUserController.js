var controllerName = 'viewUserController',
  viewUserController = {};

function Controller() {
  var vm = this;
  vm.ivo = "ivo";
  vm.btns = ['Home', 'Settings', 'About Us', 'Technologies', 'Contatct Us'];
  vm.state = ['home', 'settings', 'about', 'tech', 'contact'];
  vm.state = vm.state.map(state);

  function state(state) {
    var parent = 'user.';
    return parent + state;
  }
}

viewUserController.controllerName = controllerName;
viewUserController.controller = Controller;

export var viewUserController = viewUserController;
