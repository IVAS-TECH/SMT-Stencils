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
  price:
    type: Number
    default: 0
  orderDate:
    type: Date
    default: Date.now
  sendingDate:
    type: Date
    default: Date.now
  files: [String]
  topText: String
  bottomText: String
  configuration: require "./config/configSchem"
  information: require "./addresses/addressesSchem"

module.exports = mongoose.model "Order", schema
