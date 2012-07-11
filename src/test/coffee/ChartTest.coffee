graphWidth = 1200
graphHeight = 800
dotSize = 3

title = "Curves and Bonds"

xAxis = {min: 0, max: 50, majorStep: 10, minorStep: 1, title: "Years to maturity"}
yAxis = {min: 0, max: 30, majorStep: 10, minorStep: 1, title: "Yield"}

data = []
curves = []

drawGraph = () ->

  console.log("---> Start")
  startTime = new Date()

  chart = new suthchart.Chart(graphWidth, graphHeight)

  window.mydata = data # to aid debugging
  window.mycurves = curves # to aid debugging
  
  pointsx = _.map(data, (d) -> parseFloat(d[7]))
  pointsy = _.map(data, (d) -> parseFloat(d[9]))
  pointsdata = _.map(data, (d) -> d[0])

  chart.margins(50,50,50,50)
  chart.xAxis("Years to maturity", 0, 50, 10, 1)
  chart.yAxis("Yield", 0, 30, 10, 1)

  chart.add(chart.title("Curves and Bonds"))
  chart.add(chart.grid())
  chart.add(chart.axis())

  # Curves
  curveGroup = chart.group("curves")
  _.each(curves, (curve,key) ->
    range = _.range(0, curve.length-1, 4)
    points = _.map(range, (i) ->
      [chart.sx(curve[i].yearsToMaturity), chart.sy(curve[i].yield)]
    )
    curveGroup.add(chart.curve(points).withStroke(0.5, 'red'))
  )
  chart.add(curveGroup)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
  # Points
  pointGroup = chart.group("points")
  for p,i in pointsx
    c = pointGroup.add(chart.circle(chart.sx(pointsx[i]), chart.sy(pointsy[i]), dotSize).withStroke(1, 'green').withFill('#888').withOpacity(0.5).withID(i)) # .attr({fill: "#888", opacity: 0.5})
  chart.add(pointGroup)
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

  # Create a single manual popup for testing...
  popupX = 640
  popupY = 515
  popupWidth = 150
  popupHeight = 35
  popupGroup = chart.group("popup",popupX,popupY)
  popupGroup.add(chart.rectangle(1,1,popupWidth + 1,popupHeight + 1,5,5).withStrokeWidth(0).withFillColor('black').withOpacity(0.1))
  popupGroup.add(chart.rectangle(0,0,popupWidth,popupHeight,5,5).withFillColor('black').withOpacity(0.75))
  popupGroup.add(chart.text(5,10, "XX012345678").withFont('arial', 12).withStrokeColor('white').withAnchoring('start').withOpacity(0.75))
  popupGroup.add(chart.text(5, 25, "Royal Bank of Scotland").withFont('arial', 12).withStrokeColor('white').withAnchoring('start').withFontWeight('bold').withOpacity(0.75))
  chart.add(popupGroup)

  endTime = new Date()
  console.log("Time to construct graph object: #{endTime - startTime}")

  document.getElementById('graph').innerHTML = chart.render()

  renderEndTime = new Date()
  console.log("Time to render graph: #{renderEndTime - endTime}")

  test = $('#graph')

  domProcessingEndTime = new Date()
  console.log("Time for browser to complete rendering the DOM: #{domProcessingEndTime - renderEndTime}")

  # console.log(chart.render())
  # console.log(chart)

  $('#graph').on('click', '.sd-circle', (event) ->
    e = chart.activeElement(this)
    selected = $('.sd-circle.selected')[0]
    if selected?
      olde = chart.activeElement(selected)
      olde.setFillColor('#888').setStrokeColor('green').setStrokeWidth(1).setOpacity(0.5).setRadius(3).removeClass('selected')
    e.setStrokeColor('red').setStrokeWidth(2).setOpacity(0.75).setRadius(6).addClass('selected')
    window.suthchart.x = this
    i = e.id
    # alert("clicked on bond #{data[i][0]} issued by #{data[i][2]}")
  )

  jQueryEndTime = new Date()
  console.log("Time to set up jQuery event handling: #{jQueryEndTime - domProcessingEndTime}")


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
