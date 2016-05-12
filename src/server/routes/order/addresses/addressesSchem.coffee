address =
  country: String
  city: String
  postcode: String
  address1: String
  address2: String
  firstname: String
  lastname: String

module.exports =
  name:
    type: String
    unique: yes
    required: yes
    mongoose: yes
  user: "User"
  delivery: address
  invoice: address
  firm: address
