mongoose = require "mongoose"

schema = new mongoose.Schema
  order:
    type: mongoose.Schema.Types.ObjectId
    ref: "Order"
  user:
    type: mongoose.Schema.Types.ObjectId
    ref: "User"

module.exports = mongoose.model "Notification", schema
