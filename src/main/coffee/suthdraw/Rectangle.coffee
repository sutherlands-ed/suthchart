class Rectangle extends suthdraw.Element

  type: 'rectangle'
  strokeWidth: 1
  strokeColor: '#000'
  fillColor: '#EEE'
  opacity: 1
  crispEdges: true

  constructor: (x,y, width,height, rx = 0, ry = 0) ->
    @x = x
    @y = y
    @width = width
    @height = height
    @rx = rx
    @ry = ry

window.suthdraw ?= {}
window.suthdraw.Rectangle = Rectangle
