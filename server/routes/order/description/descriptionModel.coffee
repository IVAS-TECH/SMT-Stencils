mongoose = require "mongoose"

schema = new mongoose.Schema
  order: mongoose.Schema.Types.ObjectId
  text: [String]

module.exports = mongoose.model "Description", schema
