mongoose = require "mongoose"

schema = new mongoose.Schema
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  access:
    type: Number
    default: 0

module.exports = mongoose.model "Admin", schema
