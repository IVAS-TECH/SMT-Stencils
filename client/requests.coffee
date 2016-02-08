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
    alias: ["find", "register", "email", "profile", "remove"]
    method: ["get", "post", "put", "patch", "delete"]
    arg: [no, yes, yes, yes, yes]

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
    alias: ["find", "remove"]
    method: ["get", "delete"]
    arg: [yes, yes]

  visit:
    alias: ["find"]
    method: ["get"]
    arg: [no]

  notification:
    alias: ["find", "remove"]
    method: ["get", "delete"]
    arg: [no, yes]

  language:
    alias: ["find"]
    method: ["get"]
    arg: [yes]

  upload: ["preview", "order"]
