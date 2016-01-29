mongoose = require "mongoose"

schema = new mongoose.Schema
  ip: String
  user: Boolean
  date: String

module.exports = mongoose.model "Visit", schema
