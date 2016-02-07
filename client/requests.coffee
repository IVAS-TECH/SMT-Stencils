crud =
  alias: ["find", "create", "remove", "update"]
  method: ["get", "post", "delete", "patch"]
  arg: [no, yes, yes, yes]

order = {}

order[key] = value for key, value of crud

order.alias.push "view"
order.method.push "put"
order.arg.push yes

module.exports =

  user:
    alias: ["email", "register", "profile", "remove"]
    method: ["get", "post", "patch", "delete"]
    arg: [yes, yes, yes, yes]

  login:
    alias: ["logged", "login", "logout"]
    method: ["get", "post", "delete"]
    arg: [no, yes, no]

  configuration: crud

  addresses: crud

  order: order

  template:
    alias: ["fetch"]
    method: ["get"]
    arg: [yes]

  description:
    alias: ["find"]
    method: ["get"]
    arg: [yes]

  visit:
    alias: ["find"]
    method: ["get"]
    arg: [no]

  notification:
    alias: ["find", "remove"]
    method: ["get", "delete"]
    arg: [no, yes]

  language:
    alias: ["find", "change"]
    method: ["get", "post"]
    arg: [yes, yes]

  upload: ["preview", "order"]
