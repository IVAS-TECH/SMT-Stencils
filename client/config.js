config.$inject = ['stateHelperProvider', '$mdThemingProvider'];

function config(stateHelperProvider, $mdThemingProvider) {
    configStates(stateHelperProvider);
    configTheme($mdThemingProvider);
}

function configStates(stateHelperProvider) {
  var homeState = {},
    aboutState = {},
    techState = {},
    contactState = {},
    settingsState = {},
    settingsProfileState = {},
    settingsConfigsState = {},
    settingsDeliveryState = {};

  homeState.name = 'home';
  homeState.templateUrl = 'view-home';
  homeState.controller = 'viewHomeController as vm';
  homeState.children = [aboutState, techState, contactState, settingsState];
  homeState.dsr = true;

  aboutState.name = 'about';
  aboutState.templateUrl = 'stencil';

  techState.name = 'tech';
  techState.templateUrl = 'file-upload';
  techState.controller = 'fileUploadCtrl as vm';

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
      .primaryPalette('teal')
      .accentPalette('deep-purple')
      .warnPalette('amber')
      .backgroundPalette('blue-grey')
      .dark()
      .dark();
}

export var config = config;
