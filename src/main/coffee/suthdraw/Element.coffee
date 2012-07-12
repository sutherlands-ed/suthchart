class Element

  constructor: ->

  hidden: ->
    @hidden = true
    @

  withStroke: (@strokeWidth, @strokeColor) -> @

  withFill: (@fillColor) -> @

  withStrokeWidth: (@strokeWidth) -> @

  withStrokeColor: (@strokeColor) -> @

  withFillColor: (@fillColor) -> @

  withOpacity: (@opacity) -> @

  withCrispEdges: (@crispEdges = true) -> @

  withRotation: (@rotationAngle) -> @

  withID: (@id) -> @

window.suthdraw ?= {}
window.suthdraw.Element = Element
