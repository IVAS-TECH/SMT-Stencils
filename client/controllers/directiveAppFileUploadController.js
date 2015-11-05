var controllerName = 'directiveAppFileUploadController';
var directiveAppFileUploadController = {};

Controller.$inject = ['Upload'];

function Controller(Upload) {
  var vm = this;
  vm.files = [];
  vm.view = view;
  vm.removeFile = removeFile;

  function removeFile(i) {
    vm.files.splice(i, 1);
  }

  function view() {
    var upload = {};
    upload.url = '/files';
    upload.data = {};
    upload.data.file = vm.files;
    //Upload.upload(upload);
  }
}

directiveAppFileUploadController.controllerName = controllerName;
directiveAppFileUploadController.controller = Controller;

export var directiveAppFileUploadController = directiveAppFileUploadController;
