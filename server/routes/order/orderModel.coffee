mongoose = require "mongoose"

schema = new mongoose.Schema
  style:
    frame: Boolean
    outline: Boolean
    layout: Boolean
    mode: String
  status:
    type: String
    default: "new"
  files: [String]
  topText: String
  bottomText: String
  configuration: require "./config/configSchem"
  information: require "./addresses/addressesSchem"

module.exports = mongoose.model "Order", schema