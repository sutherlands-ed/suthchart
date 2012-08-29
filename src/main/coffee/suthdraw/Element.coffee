class Element

  constructor: ->
    @opacity = 1

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

  withCursor: (@cursor) -> @

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Element = Element
