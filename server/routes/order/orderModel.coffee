makeModel = require "./../../lib/makeModel"

file = [String, ""]

date = [Date, Date.now]

module.exports = makeModel "Order",
  style:
    frame: Boolean
    outline: Boolean
    layout: Boolean
    mode: String
  status: [String, "new"]
  price: [Number, 0]
  orderDate: date
  sendingDate: date
  user: "User"
  files:
    top: file
    bottom: file
    outline: file
  topText: [String]
  bottomText: [String]
  configurationObject: require "./configuration/configurationSchem"
  addressesObject: require "./addresses/addressesSchem"
