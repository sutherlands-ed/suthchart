class Oval extends suthdraw.Element

  type: 'oval'
  strokeWidth: 1
  strokeColor: '#FFF'
  fillColor: '#888'
  opacity: 1

  constructor: (x, y, rx, ry) ->
    @x = x
    @y = y
    @rx = rx
    @ry = ry

window.suthdraw ?= {}
window.suthdraw.Oval = Oval
