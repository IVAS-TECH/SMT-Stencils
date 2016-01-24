crud =
  alias: ["find", "create", "delete", "update"]
  method: ["get", "post", "delete", "patch"]
  arg: [no, yes, yes, yes]

simpleGet =
  alias: ["find"]
  method: ["get"]
  arg: [yes]

module.exports =

  user:
    alias: ["email", "register", "profile"]
    method: ["get", "post", "patch"]
    arg: (yes for i in [0..2])

  login:
    alias: ["logged", "login", "logout"]
    method: ["get", "post", "delete"]
    arg: [no, yes, no]

  configuration: crud

  addresses: crud

  order:
    alias: ["find", "create", "update", "view"]
    method: ["get", "post", "patch", "put"]
    arg: [no, yes, yes, yes]

  description: simpleGet

  notification: simpleGet 

  language:
    alias: ["get", "find", "set"]
    method: ["get", "put", "post"]
    arg: [no, yes, yes]

  upload: ["preview", "order"]
