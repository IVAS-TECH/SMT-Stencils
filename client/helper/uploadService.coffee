module.exports = (RESTProvider) ->
  @$inject = ["RESTProvider"]

  _base = ""

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: (Upload) ->
    @$inject = ["Upload"]

    (url) ->
      base = RESTProvider.getBase()
      url = [base, _base, url]
      if _base is "" then url.splice 1, 1
      if base is "" then url.splice 0, 1
      URL = url.join "\/"
      (data) ->
        Upload.upload
          url: URL
          data: data
