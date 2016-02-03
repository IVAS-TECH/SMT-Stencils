adminModel = require "./adminModel"
userModel = require "./../userModel"

module.exports = (email, access) ->

  new Promise (resolve, reject) ->

    (userModel.findOne email: email).exec()
      .then (user) ->
        (adminModel.create user: user._id, access: access)
          .then (-> resolve "#{email} is Admin now."), resolve 
      .catch resolve
