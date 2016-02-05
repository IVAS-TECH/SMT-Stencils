service = (REST) ->

  (res) ->
    sender = REST "response-error"
    sender.post
      url: res.config.url
      method: res.config.method
      headers: res.config.headers
      data: res.data

service.$inject = ["REST"]

module.exports = service
