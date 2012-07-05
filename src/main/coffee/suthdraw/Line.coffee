class Line extends suthdraw.Element

  constructor: (@x1,@y1, @x2,@y2) ->
    super()
    @type = 'line'
    @strokeWidth = 1
    @strokeColor = '#000'
    @opacity = 1
    @crispEdges = true

window.suthdraw ?= {}
window.suthdraw.Line = Line
