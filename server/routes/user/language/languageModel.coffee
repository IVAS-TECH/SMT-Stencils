mongoose = require "mongoose"

schema = new mongoose.Schema
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  language: String

module.exports = mongoose.model "Language", schema
