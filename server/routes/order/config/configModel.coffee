mongoose = require "mongoose"

schema = new mongoose.Schema require "./configSchem"

module.exports = mongoose.model "Config", schema
