mongoose = require "mongoose"

schema = new mongoose.Schema
  ip: String
  map:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"

module.exports = mongoose.model "Session", schema
