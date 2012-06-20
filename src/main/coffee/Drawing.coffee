class Drawing
  width: 500
  height: 500

  elements: []

  constructor: (width, height) ->
    @width = width
    @height = height

  add: (element) ->
    @elements.push(element)

  circle: (x,y,r) -> new suthchart.Circle(x,y,r)

  curve: (points) -> new suthchart.Curve(points)

  line: (x1,y1, x2,y2) -> new suthchart.Line(x1,y1, x2,y2)

  oval: (x,y, rx,ry) -> new suthchart.Oval(x,y, rx,ry)

  text: (x, y, text) -> new suthchart.Text(x, y, text)

  svg: () ->
    suthchart.SVGRenderer.render(this)

  vml: () ->
    suthchart.VMLRenderer.render(this)

  render: () ->
    if hasSVG()
      suthchart.SVGRenderer.render(this)
    else
      suthchart.VMLRenderer.render(this)

window.suthchart ?= {}
window.suthchart.Drawing = (width = 500, height = 500) -> new Drawing(width, height)

# PRIVATE

round = (x) -> Math.round(x)

hasSVG = () -> window.SVGDocument?

