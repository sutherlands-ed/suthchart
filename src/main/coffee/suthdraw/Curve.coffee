class Curve extends suthdraw.Element

  type: 'curve'
  strokeWidth: 1
  strokeColor: '#000'
  fillColor: '#000'
  fill: false
  opacity: 1

  constructor: (points) ->
    @points = points

window.suthdraw ?= {}
window.suthdraw.Curve = Curve
