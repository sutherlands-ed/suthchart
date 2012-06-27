class SVGElement extends ActiveElement

  setFillColor: (color) ->
    @element.style.fill = color
    this

  setStrokeColor: (color) ->
    @element.style.stroke = color
    this

  setOpacity: (opacity) ->
    @element.style.opacity = opacity
    this

  setRadius: (radius) ->
    @element.setAttribute('r', radius)
    this


window.suthdraw ?= {}
window.suthdraw.SVGElement = SVGElement
