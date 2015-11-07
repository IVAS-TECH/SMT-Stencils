config.$inject = ['stateHelperProvider', '$mdThemingProvider'];

function config(stateHelperProvider, $mdThemingProvider) {
    configStates(stateHelperProvider);
    configTheme($mdThemingProvider);

    function configStates(stateHelperProvider) {
      var homeState = {};
      var aboutState = {};
      var techState = {};
      var contactState = {};
      var settingsState = {};
      var settingsProfileState = {};
      var settingsConfigsState = {};
      var settingsDeliveryState = {};

      homeState.name = 'home';
      homeState.templateUrl = 'view-home';
      homeState.controller = 'viewHomeController as vm';
      homeState.children = [aboutState, techState, contactState, settingsState];
      homeState.dsr = true;

      aboutState.name = 'about';
      aboutState.templateUrl = 'test';

      techState.name = 'tech';
      techState.template = '<app-file-upload></app-file-upload>';

      contactState.name = 'contact';
      contactState.template = "Contact";

      settingsState.name = 'settings';
      settingsState.templateUrl = 'view-settings';
      settingsState.children = [settingsProfileState];//, SettingsConfigsState, SettingsDeliveryState];
      settingsState.dsr = true;

      settingsProfileState.name = 'profile';
      settingsProfileState.templateUrl = 'view-settings-profile';
      settingsProfileState.controller = 'viewSettingsProfileController as vm';

      stateHelperProvider
        .state(homeState);
    }

    function configTheme($mdThemingProvider) {
      $mdThemingProvider
        .theme('default')
          .primaryPalette('light-green')
          .accentPalette('blue')
          .warnPalette('deep-orange')
          .dark();
    }
}

export var config = config;
