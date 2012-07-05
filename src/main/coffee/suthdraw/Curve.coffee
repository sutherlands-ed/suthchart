class Curve extends suthdraw.Element

  constructor: (@points) ->
    @type = 'curve'
    @strokeWidth = 1
    @strokeColor = '#000'
    @fillColor = '#000'
    @fill = false
    @opacity = 1

window.suthdraw ?= {}
window.suthdraw.Curve = Curve
