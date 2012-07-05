class Oval extends suthdraw.Element

  constructor: (@x, @y, @rx, @ry) ->
    super()
    @type = 'oval'
    @strokeWidth = 1
    @strokeColor = '#FFF'
    @fillColor = '#888'
    @opacity = 1

window.suthdraw ?= {}
window.suthdraw.Oval = Oval
