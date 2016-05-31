{join} = require "path"
config = require "./multerConfig"
query = require "./../../../lib/query"
GerberToSVGMiddleware = require "./../../../lib/GerberToSVG/GerberToSVGMiddleware"
multerConfig = config join __dirname, "./../../../files"
tryCleanGerber = require "./tryCleanGerber"

transformReq = (prop, info) -> (req, res, next) ->
    req[prop] = {}
    req[prop][req.body.map[file.originalname]] = file[info] for file in req.files
    next()

layers = ["top", "bottom", "outline"]

module.exports =
    order: post: [
        multerConfig.order().any()
        transformReq "fileNames", "filename"
        transformReq "gerbers", "path"
        (req, res, next) ->
            send = -> query res, files: req.fileNames
            if req.fileStorage?
                upload = (file) -> new Promise (resolve, reject) ->
                    req.fileStorage.upload file, (err, info) -> if err then reject err else resolve info
                promises = ((if req.gerbers[layer]? then upload req.gerbers[layer]) for layer in layers)
                (Promise.all promises).then (-> send()), next
            else send()
    ]

    preview: post: [
        multerConfig.preview().any()
        transformReq "gerbers", "path"
        GerberToSVGMiddleware "top"
        GerberToSVGMiddleware "bottom"
        tryCleanGerber "top"
        tryCleanGerber "bottom"
        tryCleanGerber "outline"
        GerberToSVGMiddleware "send"
    ]
