function Directive () {
  var directive = {};
  directive.restrict = 'A';
  directive.link = link;

  function link (scope, element, attributes, ngModel) {
    var messages = scope.$eval(attributes.msg);

    if(attributes.use) {
      var expretion = attributes.use.split(' as '),
        access = '.',
        replaced = expretion[0] + access,
        replacer = expretion[1] + access,
        delimiter = ',',
        items = attributes.error.split(delimiter),
        done = items.map(replace);

      attributes.error = done.join(delimiter);
      
      function replace (item) {
        var newItem = item.replace(replacer, replaced);
        return newItem;
      }
    }

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
