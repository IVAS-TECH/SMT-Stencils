crud =
  alias: ["find", "create", "delete", "update"]
  method: ["get", "post", "delete", "patch"]
  arg: [no, yes, yes, yes]

order = {}

order[key] = value for key, value of crud

order.alias.push "view"
order.method.push "put"
order.arg.push yes

module.exports =

  user:
    alias: ["email", "register", "profile"]
    method: ["get", "post", "patch"]
    arg: [yes, yes, yes]

  login:
    alias: ["logged", "login", "logout"]
    method: ["get", "post", "delete"]
    arg: [no, yes, no]

  configuration: crud

  addresses: crud

  order: order

  description:
    alias: ["find"]
    method: ["get"]
    arg: [yes]

  notification:
    alias: ["find", "remove"]
    method: ["get", "delete"]
    arg: [no, yes]

  language:
    alias: ["find", "change"]
    method: ["get", "post"]
    arg: [yes, yes]

  upload: ["preview", "order"]
