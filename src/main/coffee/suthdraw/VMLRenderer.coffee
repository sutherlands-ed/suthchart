class VMLRenderer extends suthdraw.Renderer

  render: (drawing) ->
    html = []
    html.push("""<div style="clip:rect(0px #{drawing.width}px #{drawing.height}px 0px); position:relative; width:#{drawing.width}px;display:inline-block;height:#{drawing.height}px;overflow:hidden;top:0px; left:0px;cursor:arrow">""")
    for e in drawing.elements
      html.push(@renderElement(e))
    html.push("""</div>""")
    html.join('')

  renderElement: (e) ->
    crisp = if (e.crispEdges)
      crisp = VMLRenderer.crispEdgeFunction(e.strokeWidth)
    else
      crisp = VMLRenderer.roundCoord

    switch e.type
      when 'circle'
        """<v:oval #{VMLRenderer.idIfSet(e)}class="sd-circle" style="position:absolute;left:#{crisp(e.x-e.r)}px;top:#{crisp(e.y-e.r)}px;width:#{e.r * 2}px;height:#{e.r * 2}px;" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}"><v:stroke opacity="#{e.opacity}" miterlimit="8"></v:stroke><v:fill type="solid" opacity="#{e.opacity}"></v:fill></v:oval>"""
      when 'curve'
        points = ([crisp(x[0]), crisp(x[1])] for x in e.points)
        first = _.first(points)
        rest = _.rest(points)
        lines = _.chain(rest).map( (x) -> "," + x).reduce((x,y) -> x + y).value().substring(1)
        last = _.last(points)
        path = "m" + first + "c" + lines + "," + last + " e"
        """<v:shape #{VMLRenderer.idIfSet(e)}class="sd-curve" style="position:absolute;width:1px;height:1px;top:0px;left:0px" coordsize="1,1" filled="f" stroked="t" strokecolor="#{e.strokeColor}" strokeweight="#{e.strokeWidth}px" path="#{path}"><v:stroke opacity="#{e.strokeWidth}" miterlimit="8"></v:stroke><v:fill></v:fill></v:shape>"""
      when 'group'
        html = []
        html.push("""<div #{VMLRenderer.idIfSet(e)}class="sd-group" style="position:absolute;left:#{e.x}px;top:#{e.y}px;width:1px;height:1px#{VMLRenderer.styleAddition(e)}">""")
        for x in e.elements
          html.push(@renderElement(x))
        html.push("""</div>""")
        html.join('')
      when 'line'
        """<v:line #{VMLRenderer.idIfSet(e)}class="sd-line" from="#{crisp(e.x1)}px,#{crisp(e.y1)}px" to="#{crisp(e.x2)}px,#{crisp(e.y2)}px" strokecolor="#{e.strokeColor}" strokeweight="#{e.strokeWidth}px"><v:stroke opacity="#{e.strokeWidth}" miterlimit="8"></v:stroke></v:line>"""
      when 'oval'
        """<v:oval #{VMLRenderer.idIfSet(e)}class="sd-oval" style="position:absolute;left:#{crisp(e.x-e.rx)}px;top:#{crisp(e.y-e.ry)}px;width:#{e.rx * 2}px;height:#{e.ry * 2}px;" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}"><v:stroke opacity="#{e.opacity}" miterlimit="8"></v:stroke><v:fill type="solid" opacity="#{e.opacity}"></v:fill></v:oval>"""
      when 'rectangle'
        if (e.rx > 0 || e.ry > 0)
          r = (e.rx + e.ry) / 2
          arcsize = r / Math.min(e.width, e.height)
          """<v:roundrect #{VMLRenderer.idIfSet(e)}class="sd-rectangle" style="position:absolute;left:#{crisp(e.x)}px;top:#{crisp(e.y)}px;width:#{e.width}px;height:#{e.height}px" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}" strokeweight="#{e.strokeWidth}px" arcsize="#{arcsize}"><v:stroke opacity="#{e.strokeWidth}" miterlimit="8"></v:stroke><v:fill type="solid" opacity="#{e.opacity}"></v:fill></v:roundrect>"""
        else
          """<v:rect #{VMLRenderer.idIfSet(e)}class="sd-rectangle" style="position:absolute;left:#{crisp(e.x)}px;top:#{crisp(e.y)}px;width:#{e.width}px;height:#{e.height}px" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}" strokeweight="#{e.strokeWidth}px"><v:stroke opacity="#{e.strokeWidth}" miterlimit="8"></v:stroke><v:fill type="solid" opacity="#{e.opacity}"></v:fill></v:rect>"""
      when 'text'
        if (e.rotationAngle == 0)
          """<v:shape #{VMLRenderer.idIfSet(e)}class="sd-text" coordsize="1,1" style="position:absolute;width:1px;height:1px;top:0px;left:0px;" filled="t" fillcolor="#{e.strokeColor}" stroked="f" path="m#{Math.round(e.x - 1)},#{Math.round(e.y)}r1,0e"><v:stroke opacity="1" miterlimit="8"></v:stroke><v:textpath style="font-family=#{e.fontFamily};font-size:#{e.fontSize}px;font-weight:#{e.fontWeight};v-text-align:#{e.textAlign()};" on="t" string="#{e.text}"></v:textpath><v:path textpathok="t"></v:path><v:skew on="t" matrix="1,0,0,1,0,0" offset="0,0"></v:skew><v:fill type="solid"></v:fill></v:shape>"""
        else
          """<v:shape #{VMLRenderer.idIfSet(e)}class="sd-text" coordsize="1,1" style="position:absolute;width:1px;height:1px;top:0px;left:0px;" filled="t" fillcolor="#{e.strokeColor}" stroked="f" path="m#0,0r1,0e"><v:stroke opacity="1" miterlimit="8"></v:stroke><v:textpath style="font-family=#{e.fontFamily};font-size:#{e.fontSize}px;font-weight:#{e.fontWeight};v-text-align:#{e.textAlign()};" on="t" string="#{e.text}"></v:textpath><v:path textpathok="t"></v:path><v:skew on="t" matrix="#{VMLRenderer.rotationMatrix(e.rotationAngle)}" offset="#{Math.round(e.x - 1)},#{Math.round(e.y)}"></v:skew><v:fill type="solid"></v:fill></v:shape>"""
          # 0,1,-1,0,0,0
      else
        console.log("Unhandled element type: #{e.type}")

  # Object functions

  @crispEdgeFunction: (width) ->
    offset = if (width <= 1)
      0
    else
      (Math.round(width - 1) % 2) / 2
    (x) -> Math.round(x) + offset

  @roundCoord: (x) -> Math.round(x)

  @radians: (d) -> d * (Math.PI / 180)

  @rotationMatrix: (d) ->
    r = VMLRenderer.radians(d)
    # VML matrix manipulation does not handle scientific notation well.  The use of `toFixed` and `Number` force the
    # results to be presented in non-scientific notation but prevent the unnecessary inclusion of decimal paces that
    # just contain zeros.
    cos = Number(Math.cos(r).toFixed(9))
    sin = Number(Math.sin(r).toFixed(9))
    "#{cos},#{-sin},#{sin},#{cos},0,0"

  @groupTransform: (x, y) ->
    if (x ? 0) > 0 && (y ? 0) > 0
      """coordorigin="#{x ? 0},#{y ? 0}" """
    else
      """coordorigin="0,0" """


root = global ? window
root.suthdraw ?= {}
root.suthdraw.VMLRenderer = new VMLRenderer()

