class Element

  withStroke: (width, color) =>
    @strokeWidth = width
    @strokeColor = color
    this

  withFill: (color) =>
    @fillColor = color
    this

  withStrokeWidth: (width) =>
    @strokeWidth = width
    this

  withStrokeColor: (color) =>
    @strokeColor = color
    this

  withFillColor: (color) =>
    @fillColor = color
    this

  withOpacity: (opacity) =>
    @opacity = opacity
    this

  withCrispEdges: (state = true) =>
    @crispEdges = state
    this

window.suthchart ?= {}
window.suthchart.Element = Element
