HTTP = require "./HTTP"

class REST
  constructor: (@base = "") ->
  make: (res) -> new HTTP if @base isnt "" then "#{@base}/#{res}" else res

module.exports = REST
