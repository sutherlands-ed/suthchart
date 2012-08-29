class Drawing

  constructor: (@width = 500, @height = 500) ->
    @elements = []
    if hasVML() then enableVMLRendering()

  add: (element) ->
    @elements.push(element)

  circle: (x,y,r) -> new suthdraw.Circle(x,y,r)

  curve: (points) -> new suthdraw.Curve(points)

  group: (id, x, y) -> new suthdraw.Group(id, x, y)

  line: (x1,y1, x2,y2) -> new suthdraw.Line(x1,y1, x2,y2)

  oval: (x,y, rx,ry) -> new suthdraw.Oval(x,y, rx,ry)

  path: (points) -> new suthdraw.Path(points)

  rectangle: (x1, y1, x2, y2, rx,ry) -> new suthdraw.Rectangle(x1,y1, x2,y2, rx,ry)

  text: (x, y, text) -> new suthdraw.Text(x, y, text)

  # Return an object representing the element of the VML or SVG rendered drawing for the element passed to this
  # function.  This provides a standardised interface for interacting with such elements regardless of whether they
  # are VML or SVG.
  activeElement: (element) ->
    if element.ownerSVGElement?
      new suthdraw.SVGElement(element)
    else
      new suthdraw.VMLElement(element)

  svg: () -> suthdraw.SVGRenderer.render(this)

  vml: () -> suthdraw.VMLRenderer.render(this)

  render: () ->
    if hasSVG()
      suthdraw.SVGRenderer.render(this)
    else
      suthdraw.VMLRenderer.render(this)

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Drawing = Drawing

# PRIVATE

round = (x) -> Math.round(x)

hasSVG = () -> root.SVGDocument?

hasVML = () -> document? && !hasSVG()

enableVMLRendering = () ->
  # Check whether the namespace has already been set.  Only set it once!
  if ! (_.find(document.namespaces, (ns) -> ns.name == 'v'))?
    document.namespaces.add('v','urn:schemas-microsoft-com:vml', '#default#VML')
    if(!document.documentMode || document.documentMode < 8)
      styles = document.createElement('style')
      styles.type = 'text/css'
      styles.styleSheet.cssText = 'v\:*{behavior: url(#default#VML);}'
      document.getElementsByTagName('head')[0].appendChild(styles)

# Setup default console.log for IE

root.console ?= {}
root.console.log ?= () ->
  # Do nothing if no implementation of Console.log exists.
