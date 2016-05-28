{join} = require "path"
{createWriteStream} = require "fs"
express = require "express"
bodyParser = require "body-parser"
errorLogger = require "./errorLogger"
errorHandler = require "./errorHandler"
errorStream = createWriteStream (join __dirname, "logs/error.log"), flags: "a"

module.exports =
    beforeEach: [
        bodyParser.json()
        errorLogger errorStream
        express.static (join __dirname, 'send'), setHeaders: (res, path, stat) ->
            res.set "Content-Encoding", "gzip"
    ]

    api: require "./routes/routes"

    afterEach: [
        (req, res, next) -> next new Error "Not Found"
        errorHandler errorStream, "/#!/notfound"
    ]
