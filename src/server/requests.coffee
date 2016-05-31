{join} = require "path"
fs = require "fs"
zlib = require "zlib"
express = require "express"
gcloud = require "gcloud"
bodyParser = require "body-parser"
errorLogger = require "./errorLogger"
errorHandler = require "./errorHandler"
project = process.env.Project_ID
storage = if project? then (gcloud projectId: project).storage().bucket project
errorReqStream = fs.createWriteStream (join __dirname, "logs/request.log"), flags: "a"
errorStream = fs.createWriteStream (join __dirname, "logs/error.log"), flags: "a"

module.exports =
    beforeEach: [
        bodyParser.json()
        errorLogger errorReqStream
        express.static (join __dirname, 'send'), setHeaders: (res, path, stat) ->
            res.set "Content-Encoding", "gzip"
        (req, res, next) ->
            req.fileStorage = storage
            next()
    ]

    api: require "./routes/routes"

    afterEach: [
        (req, res, next) -> next new Error "Not Found"
        errorHandler errorStream, "/#!/notfound"
    ]
