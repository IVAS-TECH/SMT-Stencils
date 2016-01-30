module.exports = (RESTProvider) ->
  @$inject = ["RESTProvider"]

  _base = ""

  setBase: (base) -> _base = base

  getBase: -> _base

  $get: (Upload) ->
    @$inject = ["Upload"]

    (url) ->

      base = RESTProvider.getBase()
      chain = [base, _base, url]
      noBase = _base is ""
      noUpload = base is ""
      URL = ""

      if noBase then chain.splice 1, 1
      if noUpload then chain.splice 0, 1

      if noBase and noUpload
        URL = "\/" + url
      else URL = chain.join "\/"

      (files) ->
        
        data = map: {}, files: []

        for layer, file of files
          data.map[file.name] = layer
          data.files.push file

        Upload.upload
          url: URL
          data: data
