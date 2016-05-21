morgan = require "morgan"

module.exports = (log) -> morgan "combined", stream: log, skip: (req, res) -> res.statusCode < 400
