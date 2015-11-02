var controllerName = 'fileUploadCtrl';
var fileUploadCtrl = {};

Controller.$inject = ['Upload'];

function Controller(Upload) {
  var vm = this;
  vm.files = [];
  vm.view = function() {
    var upload = {};
    upload.url = '/files';
    upload.data = {};
    upload.data.file = vm.files;
    Upload.upload(upload);
  }
}

fileUploadCtrl.controllerName = controllerName;
fileUploadCtrl.controller = Controller;

export var fileUploadCtrl = fileUploadCtrl;
