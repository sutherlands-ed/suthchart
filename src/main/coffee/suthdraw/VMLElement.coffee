class VMLElement extends ActiveElement

  setFillColor: (color) ->
    @element.fillcolor = color
    this

  setStrokeColor: (color) ->
    @element.strokecolor = color
    this

  setOpacity: (opacity) ->
    @element.fill.opacity = opacity
    @element.stroke.opacity = opacity
    this

  setRadius: (radius) ->
    left = Number(@element.style.left.match(///\d+///)?[0])
    top = Number(@element.style.top.match(///\d+///)?[0])
    width = Number(@element.style.width.match(///\d+///)?[0])
    height = Number(@element.style.height.match(///\d+///)?[0])
    cx = left + (width / 2)
    cy = top + (height / 2)
    left = cx - radius
    top = cy - radius
    width = radius * 2
    height = radius * 2
    @element.style.left = left + "px"
    @element.style.top = top + "px"
    @element.style.width = width + "px"
    @element.style.height = height + "px"
    this

window.suthdraw ?= {}
window.suthdraw.VMLElement = VMLElement
