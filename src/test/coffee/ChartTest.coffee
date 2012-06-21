graphWidth = 1200
graphHeight = 800
dotSize = 3

title = "Curves and Bonds"

xAxis = {min: 0, max: 50, majorStep: 10, minorStep: 1, title: "Years to maturity"}
yAxis = {min: 0, max: 30, majorStep: 10, minorStep: 1, title: "Yield"}

data = []
curves = []

drawGraph = () ->

  chart = new suthchart.Chart(graphWidth, graphHeight)

  window.mydata = data # to aid debugging
  window.mycurves = curves # to aid debugging
  
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
  sy = (y) ->
    r = ((yAxis.max - y) - yAxis.min) * (graphHeight - margin.top - margin.bottom) / (yAxis.max - yAxis.min) + margin.top

  chart.margins(50,50,50,50)
  chart.xAxis("Years to maturity", 0, 50, 10, 1)
  chart.yAxis("Yield", 0, 30, 10, 1)

  # Title
  # chart.add(chart.text(graphWidth / 2, 20, title).withFont('Arial', 16).withStrokeColor('#555'))
  chart.add(chart.title("Curves and Bonds"))
  # chart.add(chart.grid())
  # chart.add(chart.axis())

  # X Grid
  for x in [xAxis.min..xAxis.max] by xAxis.minorStep
    chart.add(chart.line(sx(x), sy(yAxis.min), sx(x), sy(yAxis.max)).withStrokeWidth(0.1))
  for x in [xAxis.min..xAxis.max] by xAxis.majorStep
    chart.add(chart.line(sx(x), sy(yAxis.min), sx(x), sy(yAxis.max)).withStrokeWidth(0.2))

  # Y Grid
  for y in [yAxis.min..yAxis.max] by yAxis.minorStep
    chart.add(chart.line(sx(0), sy(y), sx(xAxis.max), sy(y)).withStrokeWidth(0.1))
  for y in [yAxis.min..yAxis.max] by yAxis.majorStep
    chart.add(chart.line(sx(0), sy(y), sx(xAxis.max), sy(y)).withStrokeWidth(0.2))

  # X Axis
  chart.add(chart.line(sx(0), sy(0), sx(xAxis.max), sy(0)).withStrokeWidth(2))
  for x in [xAxis.min..xAxis.max] by xAxis.minorStep
    chart.add(chart.line(sx(x), sy(0)-2, sx(x), sy(0)+2))
  for x in [xAxis.min..xAxis.max] by xAxis.majorStep
    chart.add(chart.line(sx(x), sy(0)-4, sx(x), sy(0)+4))
    chart.add(chart.text(sx(x), sy(0) + 10, x.toString()).withFont('Arial', 10).withStrokeColor('#888'))

  # Y Axis
  chart.add(chart.line(sx(0), sy(yAxis.max), sx(0), sy(yAxis.min)).withStrokeWidth(2))
  for y in [yAxis.min..yAxis.max] by yAxis.minorStep
    chart.add(chart.line(sx(0)-2, sy(y), sx(0)+2, sy(y)))
  for y in [yAxis.min..yAxis.max] by yAxis.majorStep
    chart.add(chart.line(sx(0)-4, sy(y), sx(0)+4, sy(y)))
    chart.add(chart.text(sx(0)-15, sy(y), y.toString()).withFont('Arial', 10).withStrokeColor('#888'))


  # X Axis Title
  chart.add(chart.text(sx((_.min(xAxis) + _.max(xAxis))/2), graphHeight - 10, xAxis.title).withFont('Arial', 12).withStrokeColor('#888'))

  # Y Axis Title
  chart.add(chart.text(10, sy((_.min(yAxis) + _.max(yAxis))/2), yAxis.title).withFont('Arial', 12).withStrokeColor('#888').withRotation(-90))

  # Curves
  _.each(curves, (curve,key) ->
    range = _.range(0, curve.length-1, 4)
    points = _.map(range, (i) ->
      [sx(curve[i].yearsToMaturity), sy(curve[i].yield)]
    )
    chart.add(chart.curve(points).withStroke(0.5, 'red'))
  )

  # Points
  for p,i in pointsx
    c = chart.add(chart.circle(sx(pointsx[i]), sy(pointsy[i]), dotSize).withStroke(1, 'green').withFill('#888').withOpacity(0.5)) # .attr({fill: "#888", opacity: 0.5})
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

  document.getElementById('graph').innerHTML = chart.render()


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
