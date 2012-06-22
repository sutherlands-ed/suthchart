class Chart extends suthdraw.Drawing

  title: (title) ->
    @text(@width / 2, @margin.top / 2, title).withFont('Arial', 16).withStrokeColor('#555')

  margins: (top, right, bottom, left) ->
    @margin = {
      top: top
      right: right
      bottom: bottom
      left: left
    }

  xAxis: (title, min, max, majorStep, minorStep) ->
    @xAxisTitle = title
    @xAxisMin = min
    @xAxisMax = max
    @xAxisMajorStep = majorStep
    @xAxisMinorStep = minorStep

  yAxis: (title, min, max, majorStep, minorStep) ->
    @yAxisTitle = title
    @yAxisMin = min
    @yAxisMax = max
    @yAxisMajorStep = majorStep
    @yAxisMinorStep = minorStep

  sx: (x) ->
    (x - @xAxisMin) * (@width - @margin.left - @margin.right) / (@xAxisMax - @xAxisMin) + @margin.left
  sy: (y) ->
    ((@yAxisMax - y) - @yAxisMin) * (@height - @margin.top - @margin.bottom) / (@yAxisMax - @yAxisMin) + @margin.top

  grid: () ->
    g = @group()
    # X Grid
    for x in [@xAxisMin..@xAxisMax] by @xAxisMinorStep
      g.add(@line(@sx(x), @sy(@yAxisMin), @sx(x), @sy(@yAxisMax)).withStrokeWidth(0.1))
    for x in [@xAxisMin..@xAxisMax] by @xAxisMajorStep
      g.add(@line(@sx(x), @sy(@yAxisMin), @sx(x), @sy(@yAxisMax)).withStrokeWidth(0.2))
    # Y Grid
    for y in [@yAxisMin..@yAxisMax] by @yAxisMinorStep
      g.add(@line(@sx(0), @sy(y), @sx(@xAxisMax), @sy(y)).withStrokeWidth(0.1))
    for y in [@yAxisMin..@yAxisMax] by @yAxisMajorStep
      g.add(@line(@sx(0), @sy(y), @sx(@xAxisMax), @sy(y)).withStrokeWidth(0.2))
    g

  axis: () ->
    g = @group()
    # X Axis
    g.add(@line(@sx(0), @sy(0), @sx(@xAxisMax), @sy(0)).withStrokeWidth(2))
    for x in [@xAxisMin..@xAxisMax] by @xAxisMinorStep
      g.add(@line(@sx(x), @sy(0)-2, @sx(x), @sy(0)+2))
    for x in [@xAxisMin..@xAxisMax] by @xAxisMajorStep
      g.add(@line(@sx(x), @sy(0)-4, @sx(x), @sy(0)+4))
      g.add(@text(@sx(x), @sy(0) + 10, x.toString()).withFont('Arial', 10).withStrokeColor('#888'))
    g.add(@text(@sx((@xAxisMin + @xAxisMax)/2), @height - (@margin.bottom / 2), @xAxisTitle).withFont('Arial', 12).withStrokeColor('#888'))
    # Y Axis
    g.add(@line(@sx(0), @sy(@yAxisMax), @sx(0), @sy(@yAxisMin)).withStrokeWidth(2))
    for y in [@yAxisMin..@yAxisMax] by @yAxisMinorStep
      g.add(@line(@sx(0)-2, @sy(y), @sx(0)+2, @sy(y)))
    for y in [@yAxisMin..@yAxisMax] by @yAxisMajorStep
      g.add(@line(@sx(0)-4, @sy(y), @sx(0)+4, @sy(y)))
      g.add(@text(@sx(0)-15, @sy(y), y.toString()).withFont('Arial', 10).withStrokeColor('#888'))
    g.add(@text(10, @sy((@yAxisMin + @yAxisMax)/2), @yAxisTitle).withFont('Arial', 12).withStrokeColor('#888').withRotation(-90))
    g

window.suthchart ?= {}
window.suthchart.Chart = Chart
