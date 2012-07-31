class Rectangle extends suthdraw.Element

  constructor: (@x,@y, @width,@height, @rx = 0, @ry = 0) ->
    super()
    @type        = 'rectangle'
    @strokeWidth = 1
    @strokeColor = '#000'
    @fillColor   = '#EEE'
    @opacity     = 1
    @crispEdges  = true

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Rectangle = Rectangle
