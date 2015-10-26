import { appShowToastService } from 'AppShowToastService';

var moduleName = 'appServices',
  appServices = {};

appServices.moduleName = moduleName;

angular
  .module(moduleName, [])
    .factory(appShowToastService.serviceName, appShowToastService.service);

export var appServices = appServices;
