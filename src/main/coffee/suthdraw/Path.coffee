class Path extends suthdraw.Element

  constructor: (@points) ->
    super()
    @type        = 'path'
    @strokeWidth = 1
    @strokeColor = '#000'
    @fillColor   = '#000'
    @fill        = false
    @opacity     = 1

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Path = Path
