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
      when 'line'
        """<rvml:line class="rvml" from="#{e.x1+0.5}px,#{e.y1+0.5}px" to="#{e.x2+0.5}px,#{e.y2+0.5}px" strokecolor="#{e.strokeColor}" strokeweight="#{e.strokeWidth}px"><rvml:stroke class="rvml" opacity="#{e.strokeWidth}" miterlimit="8"></rvml:stroke></rvml:line>"""
      when 'oval'
        """<rvml:oval class="rvml" style="position:absolute;left:#{e.x-e.rx+0.5}px;top:#{e.y-e.ry+0.5}px;width:#{e.rx * 2}px;height:#{e.ry * 2}px;" strokecolor="#{e.strokeColor}" fillcolor="#{e.fillColor}"><rvml:stroke class="rvml" opacity="#{e.opacity}" miterlimit="8"></rvml:stroke><rvml:fill class="rvml" type="solid" opacity="#{e.opacity}"></rvml:fill></rvml:oval>"""
      when 'text'
        """<rvml:shape class="rvml" coordsize="1,1" style="position:absolute;width:1px;height:1px;top:0px;left:0px;" filled="t" fillcolor="#{e.strokeColor}" stroked="f" path="m#{Math.round(e.x - 1)},#{Math.round(e.y)}r1,0e"><rvml:stroke class="rvml" opacity="1" miterlimit="8"></rvml:stroke><rvml:textpath class="rvml" style="font-family=#{e.fontFamily};font-size:#{e.fontSize}px;v-text-align:center;v-text-kern:true" on="t" string="#{e.text}"></rvml:textpath><rvml:path class="rvml" textpathok="t"></rvml:path><rvml:skew class="rvml" on="t" matrix="1,0,0,1,0,0" offset="-.5,-.5"></rvml:skew><rvml:fill class="rvml" type="solid"></rvml:fill></rvml:shape>"""
      else
        console.log("Unhandled element type: #{e.type}")

window.suthchart ?= {}
window.suthchart.VMLRenderer = new VMLRenderer()
