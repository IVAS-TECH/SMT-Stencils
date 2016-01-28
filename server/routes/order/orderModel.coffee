mongoose = require "mongoose"

file =
  type: String
  default: ""

date =
  type: Date
  default: Date.now

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
  orderDate: date
  sendingDate: date
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  files:
    top: file
    bottom: file
    outline: file
  topText: [String]
  bottomText: [String]
  configurationObject: require "./configuration/configurationSchem"
  addressesObject: require "./addresses/addressesSchem"

module.exports = mongoose.model "Order", schema
