config.$inject = ['stateHelperProvider', '$mdThemingProvider'];

function config(stateHelperProvider, $mdThemingProvider) {
    configStates(stateHelperProvider);
    configTheme($mdThemingProvider);
}

function configStates(stateHelperProvider) {
  var loginHomeState = {},
    userHomeState = {},
    aboutState = {},
    techState = {},
    contactState = {},
    loginState = {},
    userState = {},
    userSettingsProfileState = {},
    userSettingsConfigsState = {},
    userSettingsDeliveryState = {},
    userSettingsState = {},
    common = [aboutState, techState, contactState],
    loginChild = [],
    userChild = [];

  loginHomeState.name = 'home';
  loginHomeState.template = ' Login Home';

  userHomeState.name = 'home';
  userHomeState.templateUrl = 'view-user-home';

  aboutState.name = 'about';
  aboutState.template = "About";

  techState.name = 'tech';
  techState.template = "Tech";

  contactState.name = 'contact';
  contactState.template = "Contact";

  userSettingsProfileState.name = 'profile';
  userSettingsProfileState.templateUrl = 'view-user-settings-profile';
  userSettingsProfileState.controller = 'viewUserSettingsProfileController as vm';

  userSettingsState.name = 'settings';
  userSettingsState.templateUrl = 'view-user-settings';
  userSettingsState.children = [userSettingsProfileState];//, userSettingsConfigsState, userSettingsDeliveryState];

  loginChild = angular.copy(common);
  loginChild.push(loginHomeState);

  loginState.name = 'login';
  loginState.templateUrl = 'view-login';
  loginState.deepStateRedirect = true;
  loginState.children = loginChild;

  userChild = angular.copy(common);
  userChild.push(userHomeState);
  userChild.push(userSettingsState);

  userState.name = 'user';
  userState.templateUrl = 'view-user';
  userState.deepStateRedirect = true;
  userState.controller = 'viewUserController as vm';
  userState.children = userChild;


  stateHelperProvider
    .state(loginState)
    .state(userState);
}

function configTheme($mdThemingProvider) {
  $mdThemingProvider
    .theme('default')
      .primaryPalette('teal')
      .accentPalette('indigo')
      .warnPalette('red')
      .backgroundPalette('blue-grey')
      .dark()
      .dark();
}

export var config = config;
