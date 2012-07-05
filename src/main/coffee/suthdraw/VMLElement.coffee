class VMLElement extends suthdraw.ActiveElement

  setFillColor: (color) ->
    @element.fillcolor = color
    @

  setOpacity: (opacity) ->
    @element.fill.opacity = opacity
    @element.stroke.opacity = opacity
    @

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
    @

  setStrokeColor: (color) ->
    @element.strokecolor = color
    @

  setStrokeWidth: (width) ->
    @element.strokewidth = width
    @

  # OBJECT FUNCTIONS

  @numberInString: (string) ->
    Number(string.match(///\d+///)?[0])

window.suthdraw ?= {}
window.suthdraw.VMLElement = VMLElement
