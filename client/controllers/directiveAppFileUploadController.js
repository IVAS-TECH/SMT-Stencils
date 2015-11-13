var controllerName = 'directiveAppFileUploadController';
var directiveAppFileUploadController = {};

Controller.$inject = ['Upload', 'AppShowDialog', '$scope'];

function Controller(Upload, AppShowDialog, $scope) {
  var vm = this;
  vm.files = [];
  vm.fileUpload = fileUpload;
  vm.view = view;
  vm.removeFile = removeFile;

  function fileUpload(files) {
    if(files === null)
      return;

    var extention = 'Supported file formats are: .GKO, .GTL, .GTS, .GBL, .apr';
    var size = 'Maximum single file size allowed is 1GB';
    var number = 'Maximum number of files allowed is 6';
    var msg = '';
    var newFiles = newFilesOnly(files);

    if(newFiles.length === 0)
      return;

    if(!isValidNumber(newFiles))
      msg += number + ' ';
    if(!areValidExtenctions(newFiles))
      msg += extention + ' ';
    if(!areValidSizes(newFiles))
      msg += size + ' ';

    if(msg)
      AppShowDialog(msg);
    else
      for(var i = 0; i < newFiles.length; ++i)
        vm.files.push(newFiles[i]);

    function newFilesOnly(files) {
      var res = [];
      files.forEach(isNew);
      return res;

      function isNew(file) {
        var fileNames = vm.files.map(name);
        var fileName = file.name;
        if(!(_.includes(fileNames, fileName)))
          res.push(file);

        function name(item) {
          var fName = item.name;
          return fName;
        }
      }
    }

    function isValidNumber(files) {
      var number = 6;
      var valid = files.length < number;
      return valid;
    }

    function areValidExtenctions(files) {
      var valid = files.every(isValid);
      return valid;

      function isValid(item) {
        return true;
        var fileName = item.name;
        var validExtention = ['GKO', 'GTL', 'GTS', 'GBL', 'apr'];
        var file = fileName.split('.');
        var fileExtention = file[1];
        var valid = _.includes(validExtention, fileExtention);
        return valid;
      }
    }

    function areValidSizes(files) {
      var valid = files.every(isValid);
      return valid;

      function isValid(item) {
        var fileSize = item.size;
        var maxSize = 4000000000;
        var valid = fileSize < maxSize;
        return valid;
      }
    }
  }

  function removeFile(i) {
    vm.files.splice(i, 1);
  }

  function view() {
    var upload = {};
    upload.url = '/files';
    upload.data = {};
    upload.data.file = vm.files;
      Upload.upload(upload);
  }
}

directiveAppFileUploadController.controllerName = controllerName;
directiveAppFileUploadController.controller = Controller;

export var directiveAppFileUploadController = directiveAppFileUploadController;
