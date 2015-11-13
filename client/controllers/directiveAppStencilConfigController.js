Controller.$inject = ['Restangular'];

var controllerName = 'directiveAppStencilConfigController';
var directiveAppStencilConfigController = {};

function Controller(Restangular) {
  var vm = this;
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
  vm.view = {};
  vm.view.text = [];
  vm.view.stencil = [];
  vm.options = {};
  vm.options.textPosition = textPosition();
  vm.options.textAngle = textAngle();
  vm.changeTextAngle = changeTextAngle;
  vm.changeTextPosition = changeTextPosition;
  vm.changeTextSide = changeTextSide;
  vm.changeStencilSide = changeStencilSide;
  vm.changeStencilPosition = changeStencilPosition;
  vm.doCreate = doCreate;

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
    var left = {};
    left.text = 'left';
    left.value = '270deg';
    var right = {};
    right.text = 'right';
    right.value = '90deg';
    var top = {};
    top.text = 'top';
    top.value = '180deg';
    var bottom = {};
    bottom.text = 'bottom';
    bottom.value = '0deg';
    var position = vm.stencil.text.position;
    if(!position.includes('center'))
      return [left, right, top, bottom];
    if(position.includes('center '))
      return [left, right];
    if(position.includes(' center'))
      return [top, bottom];
  }

  function changeTextSide() {
    var newVal = vm.stencil.text.side;
    var text = vm.view.text;
    if(newVal === 'PCB side')
      text.css('color', 'white');
    else
      text.css('color', 'dimgrey');
  }

  function changeStencilSide() {
    var newVal = vm.stencil.position.side;
    var e = $('#stencilView');
    var selectors = ['.mb_board-out', '.mb_board-sp', '.mb_board-ss', '.mb_board-cf', '.mb_board-cu'];
    selectors.forEach(change);

    function change(selector) {
      var e = $(selector);
      if(newVal === 'PCB side')
        e.css('color', 'white');
      else
        e.css('color', 'dimgrey');
    }
  }

  function changeStencilPosition() {
    var newVal = vm.stencil.position.position;
    var gerber = $('#gerber');
    if(newVal === 'PCB centered')
      gerber.css('top', '30%');
    else
      gerber.css('top', '20%');
  }

  function changeTextAngle() {
      var newVal = vm.stencil.text.angle;
      var text = vm.view.text;
      var position = vm.stencil.text.position;
      if(position === 'top left') {
        if((newVal === '270deg' || newVal === '90deg'))
          text.css('top', '2%');
        else
          text.css('top', '0%');
      }
      if(position === 'top right') {
        if((newVal === '180deg' || newVal === '0deg')) {
          text.css('top', '1%');
          text.css('right', '-1%');
        }
        else {
          text.css('top', '3%');
          text.css('right', '-3%');
        }
      }
      if(position === 'bottom left') {
        if((newVal === '270deg' || newVal === '90deg')) {
          text.css('left', '0%');
          text.css('bottom', '2%');
        }
        else {
          text.css('left', '2%');
          text.css('bottom', '0%');
        }
      }
      if(position === 'bottom right') {
        if((newVal === '270deg' || newVal === '90deg')) {
          text.css('right', '-2%');
          text.css('bottom', '2%');
        }
        else {
          text.css('right', '2%');
          text.css('bottom', '0%');
        }
      }
      text.css('transform', `rotate(${newVal})`);
  }

  function changeTextPosition() {
      var newVal = vm.stencil.text.position;
      var text = vm.view.text;
      vm.options.textAngle = textAngle();
      if(newVal === 'top center') {
        text.css('top', '0%');
        text.css('left', '45%');
        text.css('right', '');
        text.css('bottom', '');
      }
      if(newVal === 'bottom center') {
        text.css('bottom', '0%');
        text.css('left', '43%');
        text.css('right', '0%');
        text.css('top', '');
      }
      if(newVal === 'top right') {
        text.css('top', '3%');
        text.css('right', '-3%');
        text.css('left', '');
        text.css('bottom', '');
      }
      if(newVal === 'top left') {
        text.css('top', '0%');
        text.css('left', '0%');
        text.css('right', '');
        text.css('bottom', '');
      }
      if(newVal === 'bottom right') {
        text.css('bottom', '2%');
        text.css('right', '2%');
        text.css('left', '');
        text.css('top', '');
      }
      if(newVal === 'bottom left') {
        text.css('bottom', '2%');
        text.css('left', '2%');
        text.css('right', '');
        text.css('top', '');
      }
      if(newVal === 'center left') {
        text.css('top', '45%');
        text.css('left', '');
        text.css('right', '');
        text.css('bottom', '');
      }
      if(newVal === 'center right') {
        text.css('top', '43%');
        text.css('right', '0%');
        text.css('left', '');
        text.css('bottom', '');
      }
    }
}

directiveAppStencilConfigController.controllerName = controllerName;
directiveAppStencilConfigController.controller = Controller;

export var directiveAppStencilConfigController = directiveAppStencilConfigController;
