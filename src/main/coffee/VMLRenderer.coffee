class VMLRenderer

  render: (drawing) ->
    html = []
    html.push("""<div style="CLIP: rect(0px #{drawing.width}px #{drawing.height}px 0px); POSITION: relative; WIDTH: #{drawing.width}px; DISPLAY: inline-block; HEIGHT: #{drawing.height}px; OVERFLOW: hidden; TOP: 0px; LEFT: 0px">""")
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
      else
        console.log("Unhandled element type: #{e.type}")

window.suthchart ?= {}
window.suthchart.VMLRenderer = new VMLRenderer()
