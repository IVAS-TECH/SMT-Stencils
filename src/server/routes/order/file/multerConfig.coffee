multer = require "multer"
{generate} = require "randomstring"

config = (dir, preview) -> ->
    multer
        storage: multer.diskStorage
            destination: dir + if preview then "/tmp" else ""
            filename: (req, file, cb) ->
                name = file.originalname
                fileName = name.match /\.[a-zA-Z]+/
                extention = if fileName? and fileName[0].length > 2 then "" else "." + name
                cb null, [req.user.user._id, generate(), name + extention].join "___"
        limists:
            files: 3
            fileSize: 10000000

module.exports = (dir) ->
    preview: config dir, yes
    order: config dir, no
