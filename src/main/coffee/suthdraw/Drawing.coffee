class Drawing

  constructor: (@width = 500, @height = 500) ->
    @elements = []

  add: (element) ->
    @elements.push(element)

  circle: (x,y,r) -> new suthdraw.Circle(x,y,r)

  curve: (points) -> new suthdraw.Curve(points)

  group: (id = '') -> new suthdraw.Group(id)

  line: (x1,y1, x2,y2) -> new suthdraw.Line(x1,y1, x2,y2)

  oval: (x,y, rx,ry) -> new suthdraw.Oval(x,y, rx,ry)

  rectangle: (x1, y1, x2, y2, rx,ry) -> new suthdraw.Rectangle(x1,y1, x2,y2, rx,ry)

  text: (x, y, text) -> new suthdraw.Text(x, y, text)

  # Return an object representing the element of the VML or SVG rendered drawing for the element passed to this
  # function.  This provides a standardised interface for interacting with such elements regardless of whether they
  # are VML or SVG.
  activeElement: (element) ->
    c = element.attributes.class.nodeValue
    if c.match(///rvml///)?
      new suthdraw.VMLElement(element)
    else
      new suthdraw.SVGElement(element)

  svg: () -> suthdraw.SVGRenderer.render(this)

  vml: () -> suthdraw.VMLRenderer.render(this)

  render: () ->
    if hasSVG()
      suthdraw.SVGRenderer.render(this)
    else
      suthdraw.VMLRenderer.render(this)

window.suthdraw ?= {}
window.suthdraw.Drawing = Drawing

# PRIVATE

round = (x) -> Math.round(x)

hasSVG = () -> window.SVGDocument?

