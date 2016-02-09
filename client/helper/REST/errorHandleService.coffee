service = (RESTService) ->

  (res) ->
    sender = RESTService "response-error"
    sender.post
      url: res.config.url
      method: res.config.method
      headers: res.config.headers
      data: res.data

service.$inject = ["RESTService"]

module.exports = service
