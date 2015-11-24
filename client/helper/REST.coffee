HTTP = require "./HTTP"

#h = new HTTP("register")
#h.post(user: {email: "a@a", password: "aaaaaa"}).then (r) -> console.log r

class REST
  constructor: (@base = "") ->
  make: (res) -> new HTTP if @base isnt "" then "#{@base}/#{res}" else res

module.exports = REST
