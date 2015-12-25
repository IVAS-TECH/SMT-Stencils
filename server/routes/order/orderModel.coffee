mongoose = require "mongoose"

schema = new mongoose.Schema
  status:
    type: String
    default: "New"
  files: [String]
  topText: String
  bottomText: String
  configuration: require "./config/configSchem"
  information: require "./addresses/addressesSchem"

module.exports = mongoose.model "Order", schema
