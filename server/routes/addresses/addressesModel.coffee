mongoose = require "mongoose"

address =
  country: String
  city: String
  postcode: String
  address1: String
  address2: String
  firstname: String
  lastname: String

schema = new mongoose.Schema
  name: String
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  delivery: address
  invoice: address
  firm: address

module.exports = mongoose.model "Address", schema