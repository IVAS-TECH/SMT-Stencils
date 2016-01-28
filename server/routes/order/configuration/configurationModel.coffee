mongoose = require "mongoose"

schema = new mongoose.Schema require "./configurationSchem"

module.exports = mongoose.model "Configuration", schema
