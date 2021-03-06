class VMLElement extends suthdraw.ActiveElement

  setFillColor: (color) ->
    @element.fillcolor = color
    @

  setOpacity: (opacity) ->
    @element.fill.opacity = opacity
    @element.stroke.opacity = opacity
    @

  setRadius: (radius) ->
    left   = VMLElement.numberInString(@element.style.left)
    top    = VMLElement.numberInString(@element.style.top)
    width  = VMLElement.numberInString(@element.style.width)
    height = VMLElement.numberInString(@element.style.height)
    cx     = left + (width / 2)
    cy     = top + (height / 2)
    left   = cx - radius
    top    = cy - radius
    width  = radius * 2
    height = radius * 2
    @element.style.left   = left + "px"
    @element.style.top    = top + "px"
    @element.style.width  = width + "px"
    @element.style.height = height + "px"
    @

  setStrokeColor: (color) ->
    @element.strokecolor = color
    @

  setStrokeWidth: (width) ->
    @element.strokewidth = width
    @

  getPosition: ->
    if @type == 'group'
      style = @element.style
      { left: VMLElement.numberInString(style.left), top: VMLElement.numberInString(style.top) }
    else if @type = 'circle'
      style = @element.style
      cx = VMLElement.numberInString(style.left) + VMLElement.numberInString(style.width) * 0.5
      cy = VMLElement.numberInString(style.top) + VMLElement.numberInString(style.height) * 0.5
      { left: cx, top: cy }

  setPosition: (left, top) ->
    if @type == 'circle'
      style = @element.style
      width = VMLElement.numberInString(style.width)
      height = VMLElement.numberInString(style.height)
      style.left = left - width * 0.5
      style.top = top - width * 0.5
    else
      style = @element.style
      style.left = left
      style.top = top 
    @

  setWidthHeight: (width, height) ->
    @element.style.width = width
    @element.style.height = height
    @

  getText: () ->
    @element.getElementsByTagName('textpath')[0].string

  setText: (text) ->
    @element.getElementsByTagName('textpath')[0].string = text
    @

  # OBJECT FUNCTIONS

  @numberInString: (string) ->
    Number(string.match(///\d+///)?[0])

root = global ? window
root.suthdraw ?= {}
root.suthdraw.VMLElement = VMLElement
