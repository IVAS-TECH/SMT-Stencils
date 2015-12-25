mongoose = require "mongoose"

schema = new mongoose.Schema require "./addressesSchem"

module.exports = mongoose.model "Address", schema
