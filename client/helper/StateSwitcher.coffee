module.exports = (go) ->
  class StateSwitcher
    constructor: (@parent, @child) ->
    switch: (child) -> go "#{@parent}.#{child}"
    select: (i = 0) ->
      select = (false for [0..@child.length])
      select[i] = true
      select
  (parent, child) -> new StateSwitcher parent, child
