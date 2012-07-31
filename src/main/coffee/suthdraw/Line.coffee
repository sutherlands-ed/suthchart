class Line extends suthdraw.Element

  constructor: (@x1,@y1, @x2,@y2) ->
    super()
    @type        = 'line'
    @strokeWidth = 1
    @strokeColor = '#000'
    @opacity     = 1
    @crispEdges  = true

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Line = Line
