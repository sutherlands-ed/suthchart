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

  chart.add(chart.title("Curves and Bonds"))
  chart.add(chart.grid())
  chart.add(chart.axis())


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
