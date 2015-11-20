mongoose = require "mongoose"

schema = new mongoose.Schema
  name: String
  others: String # add other fileds tommorrow

module.exports = mongoose.model "Config", schema
