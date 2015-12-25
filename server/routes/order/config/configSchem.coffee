mongoose = require "mongoose"

module.exports =
  name: String
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  fudical:
    marks: String
    side: String
  position:
    aligment: String
    position: String
    side: String
  stencil:
    size:
      type: String
      default: "default"
    tickness: String
    transitioning: String
    type:
      type: String
  text:
    angle: String
    position: String
    side:
      type: String
      default: "default"
    type:
      type: String
