graphWidth = 1200
graphHeight = 800
dotSize = 3
graphMarginLeft = 50
graphMarginRight = 50
graphMarginTop = 50
graphMarginBottom = 50

title = "Curves and Bonds"

data = []
curves = []

drawGraph = (xMin, xMax, yMin, yMax) =>

  console.log("---> Start")
  startTime = new Date()

  chart = new suthchart.Chart(graphWidth, graphHeight)

  window.mydata   = data # to aid debugging
  window.mycurves = curves # to aid debugging
  
  pointsx    = _.map(data, (d) -> parseFloat(d[7]))
  pointsy    = _.map(data, (d) -> parseFloat(d[9]))
  pointsdata = _.map(data, (d) -> d[0])

  chart.margins(graphMarginTop, graphMarginRight, graphMarginBottom, graphMarginLeft)
  chart.linearXAxis("Date", xMin, xMax)
  chart.linearYAxis("Spread (bps)", yMin, yMax)

  console.log("Figured out axes")

  # Curves
  marketSpreadHistoryPoints = _.map(dates, (date, i) ->
    [chart.sx(date), chart.sy(Number(data.spreadValues.marketSpreadHistory[i]))]
  )

  console.log("marketSpreadHistoryPoints.length = #{marketSpreadHistoryPoints.length}")

  modelSpreadHistoryPoints = _.map(dates, (date, i) ->
    [chart.sx(date), chart.sy(Number(data.spreadValues.modelSpreadHistory[i]))]
  )

  console.log("modelSpreadHistoryPoints.length = #{modelSpreadHistoryPoints.length}")

  pathGroup = chart.group("lines")
  pathGroup.add(chart.path(marketSpreadHistoryPoints).withStroke(0.5, 'red'))
  pathGroup.add(chart.path(modelSpreadHistoryPoints).withStroke(0.5, 'green'))
  chart.add(pathGroup)
                
  console.log("Lines added")

  chart.add(chart.mask(1.0))

  chart.add(chart.title("History Chart"))

  chart.add(chart.grid())
  chart.add(chart.axis())
  console.log(chart)

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

  # Drag zoom

  chart.enableZoom($('#graph')[0], drawGraph)

  jQueryEndTime = new Date()
  console.log("Time to set up jQuery event handling: #{jQueryEndTime - domProcessingEndTime}")


data = {
  "runDates": ["2012-02-24","2012-02-27","2012-02-28","2012-02-29","2012-03-01","2012-03-02","2012-03-05","2012-03-06","2012-03-07","2012-03-08","2012-03-09","2012-03-12","2012-03-13","2012-03-14","2012-03-15","2012-03-16","2012-03-19","2012-03-20","2012-03-21","2012-03-22","2012-03-23","2012-03-26","2012-03-27","2012-03-28","2012-03-29","2012-03-30","2012-03-31","2012-04-02","2012-04-03","2012-04-04","2012-04-05","2012-04-10","2012-04-11","2012-04-12","2012-04-13","2012-04-16","2012-04-17","2012-04-18","2012-04-19","2012-04-20","2012-04-23","2012-04-24","2012-04-25","2012-04-26","2012-04-27","2012-04-30","2012-05-01","2012-05-02","2012-05-03","2012-05-04","2012-05-08","2012-05-09","2012-05-10","2012-05-11","2012-05-14","2012-05-15","2012-05-16","2012-05-17","2012-05-18","2012-05-21","2012-05-22","2012-05-23","2012-05-24","2012-05-25","2012-05-28","2012-05-29","2012-05-30","2012-05-31","2012-06-01","2012-06-06","2012-06-07","2012-06-08","2012-06-11","2012-06-12","2012-06-13","2012-06-14","2012-06-15","2012-06-18","2012-06-19","2012-06-20","2012-06-21","2012-06-22","2012-06-25","2012-06-26","2012-06-27","2012-06-28","2012-06-29","2012-06-30","2012-07-02","2012-07-03","2012-07-04","2012-07-05","2012-07-06","2012-07-09","2012-07-10","2012-07-11","2012-07-12","2012-07-13","2012-07-16","2012-07-17","2012-07-18","2012-07-19","2012-07-20","2012-07-23","2012-07-24","2012-07-25","2012-07-26","2012-07-27","2012-07-30","2012-07-31","2012-08-01","2012-08-02","2012-08-03","2012-08-06","2012-08-07","2012-08-08","2012-08-09","2012-08-10","2012-08-13","2012-08-14"],
  "spreadValues": {
    "marketSpreadHistory": ["244","239","243","245","239","238","240","239","232","235","234","232","232","227","236","234","235","238","236","235","237","237","234","232","234","234","234","236","234","234","233","233","233","233","231","231","234","236","235","235","232","232","238","237","236","234","234","232","231","227","228","225","230","228","227","228","228","230","241","243","242","240","247","247","249","250","246","246","248","258","250","254","255","255","251","248","252","254","255","258","259","261","257","258","256","255","250","250","246","246","245","244","243","245","241","242","241","243","240","240","238","235","234","234","236","233","236","237","238","232","234","236","235","235","235","235","237","235","228","236"],
    "modelSpreadHistory": ["239","238","238","239","231","231","231","232","226","231","231","231","228","228","227","223","225","225","222","223","226","225","224","225","225","224","226","225","227","227","228","233","235","233","234","235","236","237","236","238","236","237","238","240","239","238","238","237","235","232","235","235","237","237","239","241","243","243","251","253","241","255","259","259","260","261","263","264","269","272","262","266","264","266","259","259","262","263","263","263","264","265","264","267","267","267","262","262","259","258","257","257","258","254","249","249","246","245","244","242","236","233","232","233","236","237","238","236","235","234","233","234","233","233","230","229","229","228","227","226"]
    }
  }

parseDate = (dateString) ->
  [year,month,day] = dateString.match(/(\d+)\-(\d+)\-(\d+)/).splice(1,3)
  new Date(+year, +month - 1, +day)
  
dates = _.map(data.runDates, (date) -> parseDate(date).getTime())

console.log(dates)

window.dates = dates

xMin = _.min(dates)
xMax = _.max(dates)

yMin = _.min([_.min(data.spreadValues.marketSpreadHistory), _.min(data.spreadValues.modelSpreadHistory)])
yMax = _.max([_.max(data.spreadValues.marketSpreadHistory), _.max(data.spreadValues.modelSpreadHistory)])

yMin = 0

console.log("xMin = #{xMin}")
console.log("xMax = #{xMax}")

drawGraph(xMin, xMax, yMin, yMax)

deselect = (chart) ->
  selected = $('.sd-circle.selected')[0]
  if selected?
    olde = chart.activeElement(selected)
    olde.setFillColor('#888').setStrokeColor('black').setStrokeWidth(1).setOpacity(0.5).setRadius(3).removeClass('selected')


