class Circle extends suthchart.Element

  type: 'circle'
  strokeWidth: 1
  strokeColor: '#FFF'
  fillColor: '#888'
  opacity: 1

  constructor: (x, y, r) ->
    @x = x
    @y = y
    @r = r

window.suthchart ?= {}
window.suthchart.Circle = Circle
