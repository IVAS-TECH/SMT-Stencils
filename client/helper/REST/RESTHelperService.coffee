module.exports = (REST, uploadService) ->
  @$inject = ["REST", "uploadService"]

  loginREST = REST "login"
  userREST = REST "user"
  configREST = REST "config"
  previewUpload = uploadService "preview"
  orderUpload = uploadService "order"
  addressesREST = REST "addresses"
  orderREST = REST "order"

  resolve = (resolver) -> (res) -> resolver res.data

  email: (email, resolver) -> userREST.get(email).then resolve resolver
  register: (user, resolver) -> userREST.post(user).then resolve resolver
  logged: (resolver) -> loginREST.get().then resolve resolver
  login: (user, resolver) -> loginREST.post(user).then resolve resolver
  logout: (resolver) -> loginREST.delete().then resolve resolver
  profile: (change, resolver) -> userREST.patch(change).then resolve resolver
  config:
    create: (config, resolver) -> configREST.post(config).then resolve resolver
    find: (resolver) -> configREST.get().then resolve resolver
    delete: (config, resolver) -> configREST.delete(config).then resolve resolver
    update: (config, resolver) -> configREST.patch(config).then resolve resolver
  upload:
    preview: (files, resolver) -> previewUpload(files).then resolve resolver
    order: (files, resolver) -> orderUpload(files).then resolve resolver
  addresses:
    create: (addresses, resolver) -> addressesREST.post(addresses).then resolve resolver
    find: (resolver) -> addressesREST.get().then resolve resolver
    delete: (addresses, resolver) -> addressesREST.delete(addresses).then resolve resolver
    update: (addresses, resolver) -> addressesREST.patch(addresses).then resolve resolver
  order:
    create: (order, resolver) -> orderREST.post(order).then resolve resolver
    find: (resolver) -> orderREST.get().then resolve resolver
    view: (order, resolver) -> orderREST.put(order).then resolve resolver
