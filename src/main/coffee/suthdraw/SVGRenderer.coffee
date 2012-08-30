class SVGRenderer extends suthdraw.Renderer

  render: (drawing) ->
    html = []
    # -webkit-user-select:none prevents the cursor changing to a text cursor when the mouse button is down over
    # the SVG. 
    html.push("""<svg height="#{drawing.height}" version="1.1" width="#{drawing.width}" xmlns="http://www.w3.org/2000/svg" style="overflow:hidden;position:relative;cursor:crosshair;-webkit-user-select:none">""")
    for e in drawing.elements
      html.push(@renderElement(e))
    html.push("""</svg>""")
    html.join('')

  renderElement: (e) ->
    crisp = if (e.crispEdges)
      crisp = SVGRenderer.crispEdgeFunction(e.strokeWidth)
    else
      crisp = SVGRenderer.roundCoord

    switch e.type
      when 'circle'
        """<circle #{SVGRenderer.idIfSet(e)}class="sd-circle" cx="#{crisp(e.x)}" cy="#{crisp(e.y)}" r="#{e.r}" fill="#{e.fillColor}" stroke="#{e.strokeColor}" #{SVGRenderer.style(e, "fill-opacity:#{e.opacity};stroke-opacity:#{e.opacity};stroke-width:#{e.strokeWidth}")}></circle>"""
      when 'curve'
        points = ([crisp(x[0]), crisp(x[1])] for x in e.points)
        # Ensure that the number of points is always divisible by 3.
        while (points.length % 3 != 0)
          points.push(points[points.length - 1])
        first  = _.first(points)
        rest   = _.rest(points)
        lines  = _.chain(rest).map( (x) -> "," + x).reduce((x,y) -> x + y).value().substring(1)
        last   = _.last(points)
        path   = "M" + first + "C" + lines + "," + last
        """<path class="sd-curve" #{SVGRenderer.idIfSet(e)}fill="none" stroke="#{e.strokeColor}" d="#{path}" stroke-width="#{e.strokeWidth}" #{SVGRenderer.style(e)}></path>"""
      when 'group'
        html = []
        html.push("""<g class="sd-group" #{SVGRenderer.idIfSet(e)}#{SVGRenderer.groupTransform(e.x, e.y)}#{SVGRenderer.style(e)}>""")
        for x in e.elements
          html.push(@renderElement(x))
        html.push("""</g>""")
        html.join('')
      when 'line'
        """<path #{SVGRenderer.idIfSet(e)}class="sd-line" stroke="#{e.strokeColor}" d="M#{crisp(e.x1)},#{crisp(e.y1)}L#{crisp(e.x2)},#{crisp(e.y2)}" stroke-width="#{e.strokeWidth}"#{SVGRenderer.style(e)}></path>"""
      when 'oval'
        """<ellipse #{SVGRenderer.idIfSet(e)}class="sd-oval" cx="#{crisp(e.x)}" cy="#{crisp(e.y)}" rx="#{e.rx}" ry="#{e.ry}" fill="#{e.fillColor}" stroke="#{e.strokeColor}" #{SVGRenderer.style(e, "fill-opacity:#{e.opacity};stroke-opacity:#{e.opacity};stroke-width:#{e.strokeWidth}")}"></circle>"""
      when 'path'
        points = ([crisp(x[0]), crisp(x[1])] for x in e.points)
        first  = _.first(points)
        rest   = _.rest(points)
        lines  = _.chain(rest).map( (x) -> "," + x).reduce((x,y) -> x + y).value().substring(1)
        path   = "M" + first + "L" + lines
        """<path #{SVGRenderer.idIfSet(e)}class="sd-curve" fill="none" stroke="#{e.strokeColor}" d="#{path}" stroke-width="#{e.strokeWidth}"#{SVGRenderer.style(e)}></path>"""
      when 'rectangle'
        """<rect #{SVGRenderer.idIfSet(e)}class="sd-rectangle" x="#{crisp(e.x)}" y="#{crisp(e.y)}" width="#{e.width}" height="#{e.height}" rx="#{e.rx}" ry="#{e.ry}" stroke="#{e.strokeColor}" #{SVGRenderer.style(e, "fill-opacity:#{e.opacity};stroke-opacity:#{e.opacity};stroke-width:#{e.strokeWidth};fill:#{e.fillColor}")}></rect>"""
      when 'text'
        transform = if (e.rotationAngle == 0)
          ""
        else
          """transform="rotate(#{e.rotationAngle},#{e.x},#{e.y})" """
        """<text #{SVGRenderer.idIfSet(e)}class="sd-text" x="#{e.x}" y="#{e.y + e.fontSize * 0.35}" #{SVGRenderer.style(e, "fill-opacity:#{e.opacity};stroke:none;font-weight:#{e.fontWeight};font-family:#{e.fontFamily};font-size:#{e.fontSize}px;fill:#{e.strokeColor};text-anchor:#{e.textAnchor}")} #{transform}>#{e.text}</text>"""
      else
        console.log("Unhandled element type: #{e.type}")

  # Object functions

  @crispEdgeFunction: (width) ->
    offset = if (width <= 1)
      0.5
    else
      (Math.round(width) % 2) / 2
    (x) -> Math.round(x) + offset

  @roundCoord: (x) -> Math.round(x)

  @groupTransform: (x, y) ->
    if (x ? 0) > 0 && (y ? 0) > 0
      """transform="translate(#{x ? 0},#{y ? 0})" """
    else
      ''

root = global ? window
root.suthdraw ?= {}
root.suthdraw.SVGRenderer = new SVGRenderer()

