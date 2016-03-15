service = ($state) ->

    (state, exclude = []) ->
        
      addIfDirectChild = (s) ->
        if not s.abstract and s.name isnt state and s.name.match state
          name = if state then s.name.replace state + ".", "" else s.name
          if name not in exclude and not name.match /\./ then return name
          
      (addIfDirectChild s for s in $state.get()).filter (e) -> e?

service.$inject = ["$state"]

module.exports = service