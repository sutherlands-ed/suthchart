class SVGElement extends suthdraw.ActiveElement

  setFillColor: (color) ->
    @element.style.fill = color
    this

  setOpacity: (opacity) ->
    @element.style.opacity = opacity
    this

  setRadius: (radius) ->
    @element.setAttribute('r', radius)
    this

  setStrokeColor: (color) ->
    @element.style.stroke = color
    this

  setStrokeWidth: (width) ->
    @element.style.strokeWidth = width
    this


window.suthdraw ?= {}
window.suthdraw.SVGElement = SVGElement
