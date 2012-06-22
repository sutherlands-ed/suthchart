class VMLRenderer

  render: (drawing) ->
    html = []
    html.push("""<div style="clip:rect(0px #{drawing.width}px #{drawing.height}px 0px); position:relative; width:#{drawing.width}px; display:inline-block; height:#{drawing.height}px; overflow:hidden; top:0px; left:0px">""")
    for e in drawing.elements
      html.push(@renderElement(e))
    html.push("""</div>""")
    html.join('')

  renderElement: (e) ->
    switch e.type
      when 'circle'
        """<rvml:oval class="rvml" style="position:absolute;left:#{e.x-e.r+0.5}px;top:#{e.y-e.r+0.5}px;width:#{e.r * 2}px;height:#{e.r * 2}px;" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}"><rvml:stroke class="rvml" opacity="#{e.opacity}" miterlimit="8"></rvml:stroke><rvml:fill class="rvml" type="solid" opacity="#{e.opacity}"></rvml:fill></rvml:oval>"""
      when 'curve'
        points = if (e.crispEdges)
          crisp = VMLRenderer.crispEdgeFunction(e.strokeWidth)
          _.map(e.points, (i) ->
            [crisp(i[0]), crisp(i[1])]
          )
        else
          round = (x) -> Math.round(x)
          _.map(e.points, (i) ->
            [round(i[0]), round(i[1])]
          )
        first = _.first(points)
        rest = _.rest(points)
        lines = _.chain(rest).map( (x) -> "," + x).reduce((x,y) -> x + y).value().substring(1)
        last = _.last(points)
        path = "m" + first + "c" + lines + "," + last + " e"
        """<rvml:shape class="rvml" style="position:absolute;width:1px;height:1px;top:0px;left:0px" coordsize="1,1" filled="f" stroked="t" strokecolor="#{e.strokeColor}" strokeweight="#{e.strokeWidth}px" path="#{path}"><rvml:stroke class="rvml" opacity="#{e.strokeWidth}" miterlimit="8"></rvml:stroke><rvml:fill class="rvml"></rvml:fill></rvml:shape>"""
      when 'line'
        if (e.crispEdges)
          crisp = VMLRenderer.crispEdgeFunction(e.strokeWidth)
          """<rvml:line class="rvml" from="#{crisp(e.x1)}px,#{crisp(e.y1)}px" to="#{crisp(e.x2)}px,#{crisp(e.y2)}px" strokecolor="#{e.strokeColor}" strokeweight="#{e.strokeWidth}px"><rvml:stroke class="rvml" opacity="#{e.strokeWidth}" miterlimit="8"></rvml:stroke></rvml:line>"""
        else
          """<rvml:line class="rvml" from="#{e.x1}px,#{e.y1}px" to="#{e.x2}px,#{e.y2}px" strokecolor="#{e.strokeColor}" strokeweight="#{e.strokeWidth}px"><rvml:stroke class="rvml" opacity="#{e.strokeWidth}" miterlimit="8"></rvml:stroke></rvml:line>"""
      when 'oval'
        """<rvml:oval class="rvml" style="position:absolute;left:#{e.x-e.rx+0.5}px;top:#{e.y-e.ry+0.5}px;width:#{e.rx * 2}px;height:#{e.ry * 2}px;" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}"><rvml:stroke class="rvml" opacity="#{e.opacity}" miterlimit="8"></rvml:stroke><rvml:fill class="rvml" type="solid" opacity="#{e.opacity}"></rvml:fill></rvml:oval>"""
      when 'text'
        if (e.rotationAngle == 0)
          """<rvml:shape class="rvml" coordsize="1,1" style="position:absolute;width:1px;height:1px;top:0px;left:0px;" filled="t" fillcolor="#{e.strokeColor}" stroked="f" path="m#{Math.round(e.x - 1)},#{Math.round(e.y)}r1,0e"><rvml:stroke class="rvml" opacity="1" miterlimit="8"></rvml:stroke><rvml:textpath class="rvml" style="font-family=#{e.fontFamily};font-size:#{e.fontSize}px;v-text-align:center;v-text-kern:true" on="t" string="#{e.text}"></rvml:textpath><rvml:path class="rvml" textpathok="t"></rvml:path><rvml:skew class="rvml" on="t" matrix="1,0,0,1,0,0" offset="0,0"></rvml:skew><rvml:fill class="rvml" type="solid"></rvml:fill></rvml:shape>"""
        else
          """<rvml:shape class="rvml" coordsize="1,1" style="position:absolute;width:1px;height:1px;top:0px;left:0px;" filled="t" fillcolor="#{e.strokeColor}" stroked="f" path="m#0,0r1,0e"><rvml:stroke class="rvml" opacity="1" miterlimit="8"></rvml:stroke><rvml:textpath class="rvml" style="font-family=#{e.fontFamily};font-size:#{e.fontSize}px;v-text-align:center;v-text-kern:true" on="t" string="#{e.text}"></rvml:textpath><rvml:path class="rvml" textpathok="t"></rvml:path><rvml:skew class="rvml" on="t" matrix="#{VMLRenderer.rotationMatrix(e.rotationAngle)}" offset="#{Math.round(e.x - 1)},#{Math.round(e.y)}"></rvml:skew><rvml:fill class="rvml" type="solid"></rvml:fill></rvml:shape>"""
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

  @radians: (d) -> d * (Math.PI / 180)

  @rotationMatrix: (d) ->
    r = VMLRenderer.radians(d)
    # VML matrix manipulation does not handle scientific notation well.  The use of `toFixed` and `Number` force the
    # results to be presented in non-scientific notation but prevent the unnecessary inclusion of decimal paces that
    # just contain zeros.
    cos = Number(Math.cos(r).toFixed(9))
    sin = Number(Math.sin(r).toFixed(9))
    "#{cos},#{-sin},#{sin},#{cos},0,0"

window.suthdraw ?= {}
window.suthdraw.VMLRenderer = new VMLRenderer()

