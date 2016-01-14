mongoose = require "mongoose"

schema = new mongoose.Schema
  style:
    frame: Boolean
    outline: Boolean
    layout: Boolean
    mode: String
  status:
    type: String
    default: "__new__"
  price:
    type: Number
    default: 0
  orderDate:
    type: Date
    default: Date.now
  sendingDate:
    type: Date
    default: Date.now
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  files: [String]
  topText: [String]
  bottomText: [String]
  configurationObject: require "./config/configSchem"
  addressesObject: require "./addresses/addressesSchem"

module.exports = mongoose.model "Order", schema
