class Drawing
  width: 500
  height: 500

  elements: []

  constructor: (width, height) ->
    @width = width
    @height = height

  add: (element) ->
    @elements.push(element)

  circle: (x,y,r, width = 1, strokeColor = '#000', fillColor = '#fff', opacity = 1) ->
    {
      type: 'circle'
      x: x
      y: y
      r: r
      strokeWidth: width
      strokeColor: strokeColor
      fillColor: fillColor
      opacity: opacity
    }

  line: (x1,y1, x2,y2, width = 1, color = '#000') ->
    {
      type: 'line'
      x1: x1
      y1: y1
      x2: x2
      y2: y2
      strokeWidth: width
      strokeColor: color
    }

  oval: (x,y, rx,ry, width = 1, strokeColor = '#000', fillColor = '#fff', opacity = 1) ->
    {
      type: 'oval'
      x: x
      y: y
      rx: rx
      ry: ry
      strokeWidth: width
      strokeColor: strokeColor
      fillColor: fillColor
      opacity: opacity
    }

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

