class Curve extends suthchart.Element

  type: 'curve'
  strokeWidth: 1
  strokeColor: '#000'
  fillColor: '#000'
  fill: false
  opacity: 1

  constructor: (points) ->
    @points = points

window.suthchart ?= {}
window.suthchart.Curve = Curve
