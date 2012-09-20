class SVGElement extends suthdraw.ActiveElement

  setFillColor: (color) ->
    @element.style.fill = color
    @

  setOpacity: (opacity) ->
    @element.style['fill-opacity'] = opacity
    @element.style['stroke-opacity'] = opacity
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

  getPosition: ->
    if @type == 'group'
      matrix = @element.transform.baseVal.getItem(0).matrix
      { left: matrix.e, top: matrix.f }
    else if @type = 'circle'
      { left: @element.cx.baseVal.value, top: @element.cy.baseVal.value }

  setPosition: (left, top) ->
    # @element.transform.baseVal.getItem(0).setTranslate(left, top)
    @element.setAttribute('transform', "translate(#{left},#{top})")
    @

  setWidthHeight: (width, height) ->
    @element.setAttribute('width', width.toString())
    @element.setAttribute('height', height.toString())
    @

  getText: () ->
    @element.textContent

  setText: (text) ->
    @element.textContent = text
    @

root = global ? window
root.suthdraw ?= {}
root.suthdraw.SVGElement = SVGElement
