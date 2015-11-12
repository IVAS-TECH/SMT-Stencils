var gerberParser = require('gerber-parser');
var fs = require('fs');

function files(req, res) {
  var reqFiles = req.files;
  reqFiles.forEach(parseIt);

  function parseIt(gerberFile) {
    var filePath = gerberFile.path;
    parseGerberFile(filePath);

    function parseGerberFile(filePath) {
      var parser = gerberParser();
      parser.on('warning', warn);
    	fs.createReadStream(filePath, {encoding: 'utf8'})
    	  .pipe(parser)
    	   .on('data', test);

    	function test(obj) {
    		console.log(obj);
    	}

    	function warn(w) {
    		console.log('warning at line ' + w.line + w.message);
    	}
    }
  }
}

module.exports = files;
