mongoose = require "mongoose"

schema = new mongoose.Schema
  ip: String
  key: String
  value: String

module.exports = mongoose.model "Session", schema
