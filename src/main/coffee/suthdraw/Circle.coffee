class Circle extends suthdraw.Element

  constructor: (@x, @y, @r) ->
    super()
    @type        = 'circle'
    @strokeWidth = 1
    @strokeColor = '#FFF'
    @fillColor   = '#888'
    @opacity     = 1
    @crispEdges  = true

window.suthdraw ?= {}
window.suthdraw.Circle = Circle
