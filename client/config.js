config.$inject = ['stateHelperProvider', '$mdThemingProvider', '$locationProvider'];

function config(stateHelperProvider, $mdThemingProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    configStates(stateHelperProvider);
    //configTheme($mdThemingProvider);

    function configStates(stateHelperProvider) {
      var homeState = {};
      var aboutState = {};
      var techState = {};
      var orderState = {};
      var contactState = {};
      var settingsState = {};
      var settingsProfileState = {};
      var settingsConfigsState = {};
      var settingsDeliveryState = {};

      homeState.name = 'home';
      homeState.templateUrl = 'view-home';
      homeState.controller = 'viewHomeController as vm';
      homeState.children = [aboutState, techState, orderState, contactState, settingsState];
      homeState.dsr = true;

      aboutState.url = '/about';
      aboutState.name = 'about';
      aboutState.template = 'about';

      techState.url = '/tech';
      techState.name = 'tech';
      techState.template = '<app-file-upload/>';

      orderState.url = '/order';
      orderState.name = 'order';
      orderState.templateUrl = 'view-order';
      orderState.controller = 'viewOrderController as vm';

      contactState.url = '/contact'
      contactState.name = 'contact';
      contactState.templateUrl = "pcb";

      settingsState.name = 'settings';
      settingsState.templateUrl = 'view-settings';
      settingsState.children = [settingsProfileState];//, SettingsConfigsState, SettingsDeliveryState];
      settingsState.dsr = true;

      settingsProfileState.name = 'profile';
      settingsProfileState.templateUrl = 'view-settings-profile';
      settingsProfileState.controller = 'viewSettingsProfileController as vm';

      stateHelperProvider.state(homeState);
    }

    function configTheme($mdThemingProvider) {
      $mdThemingProvider
        .theme('default')
          .primaryPalette('blue')
          .accentPalette('orange')
          .warnPalette('red');
    }
}

export var config = config;
