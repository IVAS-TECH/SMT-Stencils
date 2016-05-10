multer = require "multer"
randomString = require "randomstring"

config = (dir, prev) -> ->
  multer
    storage: multer.diskStorage destination: (dir + if prev then "/tmp" else ""), filename: (req, file, cb) ->
      name = file.originalname
      fileName = name.match /\.[a-zA-Z]+/
      cb null, [req.user.user._id, randomString.generate(), name + if fileName? and fileName[0].length > 2 then "" else "." + name].join "___"
    limists: files: 3, fileSize: 10000000

module.exports = (dir) -> preview: (config dir, yes), order: config dir, no
