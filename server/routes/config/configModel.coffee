mongoose = require "mongoose"

schema = new mongoose.Schema
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
    size: String
    tickness: String
    transitioning: String
    type:
      type: String
  text:
    angle: String
    position: String
    side: String
    type:
      type: String

module.exports = mongoose.model "Config", schema
