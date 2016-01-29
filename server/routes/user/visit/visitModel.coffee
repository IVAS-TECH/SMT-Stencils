mongoose = require "mongoose"

schema = new mongoose.Schema
  ip: String
  user: Boolean
  date:
    type: Date
    default: Date.now

module.exports = mongoose.model "Visit", schema
