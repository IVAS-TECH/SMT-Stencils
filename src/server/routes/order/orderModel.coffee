makeModel = require "./../../lib/makeModel"
configurationSchem = require "./configuration/configurationSchem"
addressesSchem = require "./addresses/addressesSchem"

configurationSchem.name = String
addressesSchem.name = String

date = [Date, Date.now]

module.exports = makeModel "Order",
  status: [String, "new"]
  price: [Number, 0]
  orderDate: date
  sendingDate: date
  user: "User"
  files:
    top: String
    bottom: String
    outline: String
  specific:
    fudicals: Number
    dimenstions:
      tickness: Number
      height: Number
      width: Number
  topText: [String]
  bottomText: [String]
  configurationObject: configurationSchem
  addressesObject: addressesSchem
