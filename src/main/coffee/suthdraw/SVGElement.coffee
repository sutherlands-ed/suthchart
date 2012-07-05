class SVGElement extends suthdraw.ActiveElement

  setFillColor: (color) ->
    @element.style.fill = color
    @

  setOpacity: (opacity) ->
    @element.style.opacity = opacity
    @

  setRadius: (radius) ->
    @element.setAttribute('r', radius)
    @

  setStrokeColor: (color) ->
    @element.style.stroke = color
    @

  setStrokeWidth: (width) ->
    @element.style.strokeWidth = width
    @


window.suthdraw ?= {}
window.suthdraw.SVGElement = SVGElement
