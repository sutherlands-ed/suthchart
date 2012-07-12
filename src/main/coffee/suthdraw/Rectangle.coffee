class Rectangle extends suthdraw.Element

  constructor: (@x,@y, @width,@height, @rx = 0, @ry = 0) ->
    super()
    @type        = 'rectangle'
    @strokeWidth = 1
    @strokeColor = '#000'
    @fillColor   = '#EEE'
    @opacity     = 1
    @crispEdges  = true

window.suthdraw ?= {}
window.suthdraw.Rectangle = Rectangle
