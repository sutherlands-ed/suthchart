class Drawing
  width: 500
  height: 500

  elements: []

  constructor: (width = 500, height = 500) ->
    @width = width
    @height = height

  add: (element) ->
    @elements.push(element)

  circle: (x,y,r) -> new suthdraw.Circle(x,y,r)

  curve: (points) -> new suthdraw.Curve(points)

  group: () -> new suthdraw.Group()

  line: (x1,y1, x2,y2) -> new suthdraw.Line(x1,y1, x2,y2)

  oval: (x,y, rx,ry) -> new suthdraw.Oval(x,y, rx,ry)

  text: (x, y, text) -> new suthdraw.Text(x, y, text)

  svg: () ->
    suthdraw.SVGRenderer.render(this)

  vml: () ->
    suthdraw.VMLRenderer.render(this)

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

