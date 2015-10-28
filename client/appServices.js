import { appShowDialogService } from 'AppShowDialogService';

var moduleName = 'appServices',
  appServices = {};

appServices.moduleName = moduleName;

angular
  .module(moduleName, [])
    .factory(appShowDialogService.serviceName, appShowDialogService.service);

export var appServices = appServices;
