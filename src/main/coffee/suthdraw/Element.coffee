class Element

  id: ""

  withStroke: (width, color) ->
    @strokeWidth = width
    @strokeColor = color
    this

  withFill: (color) ->
    @fillColor = color
    this

  withStrokeWidth: (width) ->
    @strokeWidth = width
    this

  withStrokeColor: (color) ->
    @strokeColor = color
    this

  withFillColor: (color) ->
    @fillColor = color
    this

  withOpacity: (opacity) ->
    @opacity = opacity
    this

  withCrispEdges: (state = true) ->
    @crispEdges = state
    this

  withRotation: (angle) ->
    @rotationAngle = angle
    this

  withID: (id) ->
    @id = id
    this

  idIfSet: () ->
    if (@id == "") then "" else "data-id=\"#{@id}\""

window.suthdraw ?= {}
window.suthdraw.Element = Element
