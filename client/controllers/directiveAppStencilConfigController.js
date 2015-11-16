Controller.$inject = ['Restangular'];

var controllerName = 'directiveAppStencilConfigController';
var directiveAppStencilConfigController = {};

function Controller(Restangular) {
  var vm = this;
  vm.frame = false
  vm.stencil = {};
  vm.stencil.name = '';
  vm.stencil.type = '';
  vm.stencil.tick = '';
  vm.stencil.fudical = {};
  vm.stencil.fudical.marks = '';
  vm.stencil.fudical.side = '';
  vm.stencil.text = {};
  vm.stencil.text.position = '';
  vm.stencil.text.angle = '';
  vm.stencil.text.side = '';
  vm.stencil.position = {};
  vm.stencil.position.position = '';
  vm.stencil.position.align = '';
  vm.stencil.position.side = '';
  vm.stencil.style = {}
  vm.stencil.style.out = false
  vm.stencil.style.lay = true
  vm.stencil.style.mode = ''
  vm.view = {};
  vm.view.text = [];
  vm.view.stencil = [];
  vm.options = {};
  vm.options.textPosition = textPosition();
  vm.options.textAngle = textAngle();
  vm.textAngle = textAngle
  vm.changeStencilPosition = changeStencilPosition;
  vm.doCreate = doCreate;
  vm.changeText = changeText
  vm.changeStencilTrans = changeStencilTrans

  function doCreate(valid) {
    if(valid) {
      var rest = Restangular.all('config');
      var config = {};
      config.config = vm.stencil;
      rest.post(config).then(success);

      function success(res) {
        console.log("res",res);
      }
    }
  }

  function textPosition() {
    var options = [];
    var directionsY = ['top', 'bottom', 'center'];
    var directionsX = ['left', 'right', 'center'];
    for(var i = 0; i < 3; ++i)
      for(var j = 0; j < 3; ++j)
        options.push(directionsY[i] + ' ' + directionsX[j]);
    options.pop();
    return options;
  }

  function textAngle() {
    var position = vm.stencil.text.position;
    if(!position || !position.includes('center'))
      return ['left', 'right', 'bottom', 'top'];
    if(position.includes('center '))
      return ['left', 'right'];
    if(position.includes(' center'))
      return ['bottom', 'top'];
  }

  function changeStencilPosition() {
    var newVal = vm.stencil.position.position;
    var mode  = vm.stencil.position.align.toLowerCase()
    if(!newVal.includes('PCB')) {
      vm.stencil.style.out = false
      vm.stencil.style.lay = newVal.includes('Lay')
      if(vm.stencil.style.lay)
        vm.stencil.style.mode = [mode, 'centered'].join('-')
      else
        vm.stencil.style.mode = [mode, 'no'].join('-')
      return;
    }
    vm.stencil.style.lay = false
    vm.stencil.style.out = true
    vm.stencil.style.mode = [mode, 'centered'].join('-')
  }

  function changeText(text) {
    var color = 'pcb-side'
    if(text.type === 'Engraved' && text.side)
      color = text.side.toLowerCase().replace(' ', '-')
    if(text.type === 'Drilled')
      color = 'drilled'
    var pos = text.position.replace(' ', '-')
    var angle = text.angle
    var angles = vm.options.textAngle
    if(!vm.stencil.text.position)
      return [color, "text-top-left-left"]
    if(!_.includes(angles, angle))
      return [color, ["text", pos, angles[0]].join('-')]
    return [color, ["text", pos, angle].join('-')]
  }

  function changeStencilTrans() {
    var newVal = vm.stencil.trans
    vm.frame = newVal.includes('frame')
  }
}

directiveAppStencilConfigController.controllerName = controllerName;
directiveAppStencilConfigController.controller = Controller;

export var directiveAppStencilConfigController = directiveAppStencilConfigController;
