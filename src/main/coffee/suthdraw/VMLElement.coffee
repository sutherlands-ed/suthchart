class VMLElement extends suthdraw.ActiveElement

  setFillColor: (color) ->
    @element.fillcolor = color
    this

  setOpacity: (opacity) ->
    @element.fill.opacity = opacity
    @element.stroke.opacity = opacity
    this

  setRadius: (radius) ->
    left = VMLElement.numberInString(@element.style.left)
    top = VMLElement.numberInString(@element.style.top)
    width = VMLElement.numberInString(@element.style.width)
    height = VMLElement.numberInString(@element.style.height)
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

  setStrokeColor: (color) ->
    @element.strokecolor = color
    this

  setStrokeWidth: (width) ->
    @element.strokewidth = width
    this

  # OBJECT FUNCTIONS

  @numberInString: (string) ->
    Number(string.match(///\d+///)?[0])

window.suthdraw ?= {}
window.suthdraw.VMLElement = VMLElement
