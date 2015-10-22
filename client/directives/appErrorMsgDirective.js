function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;
  function link (scope, element, attributes) {
    var messages = scope.$eval(attributes.msg);
    var error = attributes[directiveName];
    if(error) {
      scope.$watchCollection(error, getKeys);
      function getKeys (newValue, oldValue) {
        var replace = Object.keys(newValue);
        for(var i = 0;i < replace.length; ++i)
          attributes.error = attributes.error.replace(replace[i], error + '.' + replace[i]);
        scope.$watchCollection(attributes.error, showErrorMsg);
      }
    }
    else
      scope.$watchCollection(attributes.error, showErrorMsg);

     function showErrorMsg (newCollection) {
       for(var i = 0;i < newCollection.length; ++i)
          if(newCollection[i] === true) {
            element.html(messages[i]);
            return;
          }
          element.html('');
      }
    }

  return directive;
}

var directiveName = 'appErrorMsg',
  appErrorMsgDirective = {};

appErrorMsgDirective.directiveName = directiveName;
appErrorMsgDirective.directive = Directive;

export var appErrorMsgDirective = appErrorMsgDirective;
