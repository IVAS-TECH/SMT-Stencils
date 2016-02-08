makeModel = require "./../../lib/makeModel"

module.exports = makeModel "User",
  email: String
  password: String
  language: String
  admin: [Number, 0]
