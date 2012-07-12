class Chart extends suthdraw.Drawing

  title: (title) ->
    @text(@width / 2, @margin.top / 2, title).withFont('Arial', 16).withStrokeColor('#555').withFontWeight('bold')

  margins: (top, right, bottom, left) ->
    @margin = {
      top:    top
      right:  right
      bottom: bottom
      left:   left
    }

  xAxis: (@xAxisTitle, @xAxisMin, @xAxisMax, @xAxisMajorStep, @xAxisMinorStep) ->

  yAxis: (@yAxisTitle, @yAxisMin, @yAxisMax, @yAxisMajorStep, @yAxisMinorStep) ->

  # X Scale
  # Given an X value in the range of the graph X axis, return the X coordinate of the point on the graphic in
  # pixels.
  sx: (x) ->
    (x - @xAxisMin) * (@width - @margin.left - @margin.right) / (@xAxisMax - @xAxisMin) + @margin.left

  # Y Scale
  # Given an Y value in the range of the graph Y axis, return the Y coordinate of the point on the graphic in
  # pixels.
  sy: (y) ->
    ((@yAxisMax - y) - @yAxisMin) * (@height - @margin.top - @margin.bottom) / (@yAxisMax - @yAxisMin) + @margin.top

  # Reverse X Scale
  # Given the X coordinate of the point return the value on the range of the X axis.
  rsx: (x) ->
    (x - @margin.left) * (@xAxisMax - @xAxisMin) / (@width - @margin.left - @margin.right) + @xAxisMin

  # Reverse Y Scale
  # Given the Y coordinate of the point return the value on the range of the Y axis.
  rsy: (y) ->
    ((@height - @margin.top - @margin.bottom) - (y - @margin.top)) * (@yAxisMax - @yAxisMin) / (@height - @margin.bottom - @margin.top) + @yAxisMin

  grid: () ->
    g = @group("grid")
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
    g = @group("axis")
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
      g.add(@text(@sx(0)-5, @sy(y), y.toString()).withFont('Arial', 10).withStrokeColor('#888').withAnchoring('end'))
    g.add(@text(10, @sy((@yAxisMin + @yAxisMax)/2), @yAxisTitle).withFont('Arial', 12).withStrokeColor('#888').withRotation(-90))
    g

window.suthchart ?= {}
window.suthchart.Chart = Chart
