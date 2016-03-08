multer = require "multer"
randomString = require "random-string"

config = (prev, dir) -> ->
  multer
    storage: multer.diskStorage destination: (dir + if prev then "/tmp" else ""), filename: (req, file, cb) ->
      fileName = file.originalname
      name = [randomString(), fileName + if (fileName.match /\./)? then "" else ("." + fileName)]
      if not prev then name.unshift req.user.user._id
      cb null, name.join "___" 
    limists: files: 3, fileSize: 10000000
    
module.exports = (dir) -> preview: (config yes, dir), order: config no, dir