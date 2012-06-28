class Circle extends suthdraw.Element

  type: 'circle'
  strokeWidth: 1
  strokeColor: '#FFF'
  fillColor: '#888'
  opacity: 1
  crispEdges: true

  constructor: (x, y, r) ->
    @x = x
    @y = y
    @r = r

window.suthdraw ?= {}
window.suthdraw.Circle = Circle
