class SVGRenderer

  render: (drawing) ->
    html = []
    html.push("""<svg height="#{drawing.height}" version="1.1" width="#{drawing.width}" xmlns="http://www.w3.org/2000/svg" style="overflow: hidden; position: relative; ">""")
    for e in drawing.elements
      html.push(@renderElement(e))
    html.push("""</svg>""")
    html.join('')

  renderElement: (e) ->
    switch e.type
      when 'circle'
        """<circle #{e.idIfSet()}class="sd-circle" cx="#{e.x}" cy="#{e.y}" r="#{e.r}" fill="#{e.fillColor}" stroke="#{e.strokeColor}" style="opacity:#{e.opacity};stroke-width:#{e.strokeWidth}" opacity="#{e.opacity}"></circle>"""
      when 'curve'
        points = if (e.crispEdges)
          crisp = crispEdgeFunction(e.strokeWidth)
          _.map(e.points, (i) ->
            [crisp(i[0]), crisp(i[1])]
          )
        else
          round = (x) -> Math.round(x*10) / 10
          _.map(e.points, (i) ->
            [round(i[0]), round(i[1])]
          )
        first = _.first(points)
        rest = _.rest(points)
        lines = _.chain(rest).map( (x) -> "," + x).reduce((x,y) -> x + y).value().substring(1)
        last = _.last(points)
        path = "M" + first + "C" + lines + "," + last
        """<path #{e.idIfSet()}class="sd-curve" fill="none" stroke="#{e.strokeColor}" d="#{path}" stroke-width="#{e.strokeWidth}"></path>"""
      when 'group'
        html = []
        for e in e.elements
          html.push(@renderElement(e))
        html.join('')
      when 'line'
        if (e.crispEdges)
          crisp = SVGRenderer.crispEdgeFunction(e.strokeWidth)
          """<path #{e.idIfSet()}class="sd-line" stroke="#{e.strokeColor}" d="M#{crisp(e.x1)},#{crisp(e.y1)}L#{crisp(e.x2)},#{crisp(e.y2)}" stroke-width="#{e.strokeWidth}"></path>"""
        else
          """<path #{e.idIfSet()}class="sd-line" stroke="#{e.strokeColor}" d="M#{e.x1},#{e.y1}L#{e.x2},#{e.y2}" stroke-width="#{e.strokeWidth}"></path>"""
      when 'oval'
        """<ellipse #{e.idIfSet()}class="sd-oval" cx="#{e.x}" cy="#{e.y}" rx="#{e.rx}" ry="#{e.ry}" fill="#{e.fillColor}" stroke="#{e.strokeColor}" style="opacity:#{e.opacity};stroke-width:#{e.strokeWidth}" opacity="#{e.opacity}"></circle>"""
      when 'text'
        transform = if (e.rotationAngle == 0)
          ""
        else
          """transform="rotate(#{e.rotationAngle},#{e.x},#{e.y})" """
        """<text #{e.idIfSet()}class="sd-text" x="#{e.x}" y="#{e.y}" style="#{e.style}" text-anchor="#{e.textAnchor}" stroke="none" fill="#{e.strokeColor}" font-size="#{e.fontSize}px" font-family="#{e.fontFamily}" #{transform}><tspan dy="#{e.fontSize * 0.35}">#{e.text}</tspan></text>"""
      else
        console.log("Unhandled element type: #{e.type}")

  # Object functions

  @crispEdgeFunction: (width) ->
    offset = if (width <= 1)
      0.5
    else
      (Math.round(width) % 2) / 2
    (x) -> Math.round(x) + offset

window.suthdraw ?= {}
window.suthdraw.SVGRenderer = new SVGRenderer()

