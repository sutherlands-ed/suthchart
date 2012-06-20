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
        """<circle cx="#{e.x}" cy="#{e.y}" r="#{e.r}" fill="#{e.fillColor}" stroke="#{e.strokeColor}" style="opacity:#{e.opacity};stroke-width:#{e.strokeWidth}" opacity="#{e.opacity}"></circle>"""
      when 'line'
        """<path style="" fill="none" stroke="#{e.strokeColor}" d="M#{e.x1},#{e.y1}L#{e.x2},#{e.y2}" stroke-width="#{e.strokeWidth}"></path>"""
      when 'oval'
        """<ellipse cx="#{e.x}" cy="#{e.y}" rx="#{e.rx}" ry="#{e.ry}" fill="#{e.fillColor}" stroke="#{e.strokeColor}" style="opacity:#{e.opacity};stroke-width:#{e.strokeWidth}" opacity="#{e.opacity}"></circle>"""
      when 'text'
        # style="text-anchor:middle; font-style:normal; font-variant:normal; font-weight:normal; font-size:16px; line-height:normal; font-family:arial"
        """<text x="#{e.x}" y="#{e.y}" style="#{e.style}" text-anchor="#{e.textAnchor}" stroke="none" fill="#{e.strokeColor}" font-size="#{e.fontSize}px" font-family="#{e.fontFamily}"><tspan dy="#{e.fontSize * 0.35}">#{e.text}</tspan></text>"""
      else
        console.log("Unhandled element type: #{e.type}")


window.suthchart ?= {}
window.suthchart.SVGRenderer = new SVGRenderer()
