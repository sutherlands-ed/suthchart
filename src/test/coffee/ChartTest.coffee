graphWidth = 1200
graphHeight = 800
dotSize = 3

title = "Curves and Bonds"

xAxis = {min: 0, max: 50, majorStep: 10, minorStep: 1, title: "Years to maturity"}
yAxis = {min: 0, max: 30, majorStep: 10, minorStep: 1, title: "Yield"}

data = []
curves = []

drawGraph = () ->

  drawing = suthchart.Drawing(graphWidth, graphHeight)

  window.mydata = data # to aid debugging
  window.mycurves = curves # to aid debugging

  titleTextAttr = { 'font-size': "16px", 'font-family': "arial", fill: '#555' }
  axisTitleTextAttr = { 'font-size': "12px", 'font-family': "arial", fill: '#888' }
  axisTextAttr = { 'font-size': "10px", 'font-family': "arial", fill: '#888' }
  
  pointsx = _.map(data, (d) -> parseFloat(d[7]))
  pointsy = _.map(data, (d) -> parseFloat(d[9]))
  pointsdata = _.map(data, (d) -> d[0])

  minx = _.min(pointsx)
  miny = _.min(pointsy)
  maxx = _.max(pointsx)
  maxy = _.max(pointsy)

  margin = {
    left: 50
    right: 50
    top: 50
    bottom: 50
  }

  sx = (x) ->
    r = (x - xAxis.min) * (graphWidth - margin.left - margin.right) / (xAxis.max - xAxis.min) + margin.left
    Math.round(r)+0.5 # Align on path to generate sharp lines
  sy = (y) ->
    r = ((yAxis.max - y) - yAxis.min) * (graphHeight - margin.top - margin.bottom) / (yAxis.max - yAxis.min) + margin.top
    Math.round(r)+0.5 # Align on path to generate sharp lines

  # Title
  # paper.text(graphWidth / 2, 20, title).attr(titleTextAttr)

  # X Grid
  for x in [xAxis.min..xAxis.max] by xAxis.minorStep
    drawing.add(drawing.line(sx(x), sy(yAxis.min), sx(x), sy(yAxis.max), 0.1))
  for x in [xAxis.min..xAxis.max] by xAxis.majorStep
    drawing.add(drawing.line(sx(x), sy(yAxis.min), sx(x), sy(yAxis.max), 0.2))

  # Y Grid
  for y in [yAxis.min..yAxis.max] by yAxis.minorStep
    drawing.add(drawing.line(sx(0), sy(y), sx(xAxis.max), sy(y), 0.1))
  for y in [yAxis.min..yAxis.max] by yAxis.majorStep
    drawing.add(drawing.line(sx(0), sy(y), sx(xAxis.max), sy(y), 0.2))

  # X Axis
  drawing.add(drawing.line(sx(0)-0.5, sy(0)-0.5, sx(xAxis.max)-0.5, sy(0)-0.5, 2))
  for x in [xAxis.min..xAxis.max] by xAxis.minorStep
    drawing.add(drawing.line(sx(x), sy(0)-2, sx(x), sy(0)+2))
  for x in [xAxis.min..xAxis.max] by xAxis.majorStep
    drawing.add(drawing.line(sx(x), sy(0)-4, sx(x), sy(0)+4))
    # paper.text(sx(x), sy(0) + 10, x.toString()).attr(axisTextAttr)

  # Y Axis
  drawing.add(drawing.line(sx(0)-0.5, sy(yAxis.max)-0.5, sx(0)-0.5, sy(yAxis.min)-0.5, 2))
  for y in [yAxis.min..yAxis.max] by yAxis.minorStep
    drawing.add(drawing.line(sx(0)-2, sy(y), sx(0)+2, sy(y)))
  for y in [yAxis.min..yAxis.max] by yAxis.majorStep
    drawing.add(drawing.line(sx(0)-4, sy(y), sx(0)+4, sy(y)))
    # paper.text(sx(0)-15, sy(y), y.toString()).attr(axisTextAttr)


  # X Axis Title
  # paper.text(sx((_.min(xAxis) + _.max(xAxis))/2), graphHeight - 10, xAxis.title).attr(axisTitleTextAttr)

  # Y Axis Title
  # paper.text(10, sy((_.min(yAxis) + _.max(yAxis))/2), yAxis.title).attr(axisTitleTextAttr).transform("r270")

  # Curves
  # _.each(curves, (curve,key) ->
  #   range = _.range(0, curve.length-1, 4)
  #   points = _.map(range, (i) ->
  #     "#{sx(curve[i].yearsToMaturity)},#{sy(curve[i].yield)}"
  #   )
  #   first = _.first(points)
  #   rest = _.rest(points)
  #   lines = _.chain(rest).map( (x) -> "," + x).reduce((x,y) -> x + y).value().substring(1)
  #   last = _.last(points)
  #   path = "M" + first + "R" + lines + "," + last
  #   paper.path(path).attr({'stroke-width': 0.2})
  # )

  # Points
  for p,i in pointsx
    c = drawing.add(drawing.circle(sx(pointsx[i]), sy(pointsy[i]), dotSize, 1, '#000', '#888', 0.5)) # .attr({fill: "#888", opacity: 0.5})
    # c.id = i
    # popup = null
    # label = null

    # c.hover( (o,i) ->
    #   label = paper.set()
    #   label.push(paper.text(60, 12, pointsdata[this.id]))
    #   popup = paper.popup(this.attrs.cx + 10, this.attrs.cy, label, "right")
    #   this.attr({'r': dotSize + 2})
    # , (o,i) ->
    #   this.attr({'r': dotSize})
    #   popup.hide()
    #   label.hide()
    # )

  document.getElementById('graph').innerHTML = drawing.render()


downloadCount = 2
$.getJSON("../data/2012-05-22.json", (d) ->
  data = d.data
  downloadCount -= 1
  if downloadCount == 0 then drawGraph()
)
$.getJSON("../data/curves-2012-05-29.json", (d) ->
  curves = d
  downloadCount -= 1
  if downloadCount == 0 then drawGraph()
)
