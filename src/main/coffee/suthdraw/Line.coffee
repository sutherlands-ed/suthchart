class Line extends suthdraw.Element

  type: 'line'
  strokeWidth: 1
  strokeColor: '#000'
  opacity: 1
  crispEdges: true

  constructor: (x1,y1, x2,y2) ->
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2

window.suthdraw ?= {}
window.suthdraw.Line = Line
