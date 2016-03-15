morgan = require "morgan"

module.exports = (logStream) ->
  morgan "combined", stream: logStream, skip: (req, res) -> res.statusCode < 400
