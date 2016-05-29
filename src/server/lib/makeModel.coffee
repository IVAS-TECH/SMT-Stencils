mongoose = require "mongoose"

module.exports = (model, schema) ->

  mongoosify  = (key, value) ->
    if value instanceof Array
      return if value.length is 2 then type: value[0], default: value[1] else value

    if typeof value is "string"
      return type: mongoose.Schema.Types.ObjectId, ref: value

    if typeof value is "object"
      if value.mongoose
        delete value.mongoose
        return value
      else return schemafy value

    if key is "type" then return type: value

    value

  schemafy = (schem) ->
    schemafied = {}
    schemafied[key] = mongoosify key, value for own key, value of schem
    schemafied

  mongoose.model model,  new mongoose.Schema schemafy schema
