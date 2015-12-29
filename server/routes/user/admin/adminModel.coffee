mongoose = require "mongoose"

schema = new mongoose.Schema
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  access: Number

module.exports = mongoose.model "Admin", schema
