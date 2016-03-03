crud = ["find", "create", "remove", "update"]

order = (value for value in crud)
order.push "view"

find = ["find"]

findAndRemove = ["find", "remove"]

module.exports =

  user: ["find", "register", "email", "profile", "remove"]

  login: ["logged", "login", "logout"]

  configuration: crud

  addresses: crud

  order: order

  template: ["fetch"]

  description: findAndRemove

  visit: find

  notification: findAndRemove

  language: find

  upload: ["preview", "order"]
  
  alias:
    get: ["find", "logged", "fetch"]
    post: ["register", "login", "create"]
    delete: ["remove", "logout"]
    patch: ["update", "profile"]
    put: ["view", "email"]
