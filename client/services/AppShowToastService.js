Service.$inject = ['$mdToast'];

function Service ($mdToast) {
  function showToast(content, pos) {
    var toast = $mdToast.simple();
    toast.content(content);
    toast.action('OK');
    toast.highlightAction(true);
    toast.hideDelay(30000);
    toast.position(pos);
    toast.theme('appTheme');

    $mdToast.show(toast).then(isOk);

    function isOk(res) {
      if(res === 'ok')
        $mdToast.hide(toast);
    }
  }

  return showToast;
}

var serviceName = 'AppShowToast',
  appShowToastService = {};

appShowToastService.serviceName = serviceName;
appShowToastService.service = Service;

export var appShowToastService = appShowToastService;
