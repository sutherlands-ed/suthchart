class Curve extends suthdraw.Element

  constructor: (@points) ->
    super()
    @type        = 'curve'
    @strokeWidth = 1
    @strokeColor = '#000'
    @fillColor   = '#000'
    @fill        = false
    @opacity     = 1

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Curve = Curve
