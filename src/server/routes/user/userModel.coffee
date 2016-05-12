makeModel = require "./../../lib/makeModel"

module.exports = makeModel "User",
  email:
    type: String
    unique: yes
    required: yes
    mongoose: yes
  password: String
  language: String
  admin: [Number, 0]
