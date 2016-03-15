mongoose = require "mongoose"

module.exports = (model, schema) ->

  mongoosify  = (key, value) ->

    if value instanceof Array
      if value.length > 1 then return type: value[0], default: value[1]
      else return value

    if typeof value is "string"
      return type: mongoose.Schema.Types.ObjectId, ref: value

    if typeof value is "object" then return schemafy value

    if key is "type" then return type: value

    value

  schemafy = (schem) ->

    schemafied = {}

    schemafied[key] = mongoosify key, value for key, value of schem

    schemafied

  mongoose.model model,  new mongoose.Schema schemafy schema
