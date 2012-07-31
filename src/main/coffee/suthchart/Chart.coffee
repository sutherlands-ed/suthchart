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
    (@yAxisMax - y) * (@height - @margin.top - @margin.bottom) / (@yAxisMax - @yAxisMin) + @margin.top

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
      g.add(@line(@sx(@xAxisMin), @sy(y), @sx(@xAxisMax), @sy(y)).withStrokeWidth(0.1))
    for y in [@yAxisMin..@yAxisMax] by @yAxisMajorStep
      g.add(@line(@sx(@xAxisMin), @sy(y), @sx(@xAxisMax), @sy(y)).withStrokeWidth(0.2))
    g

  axis: () ->
    g = @group("axis")
    # X Axis
    g.add(@line(@sx(@xAxisMin), @sy(@yAxisMin), @sx(@xAxisMax), @sy(@yAxisMin)).withStrokeWidth(2))
    for x in [@xAxisMin..@xAxisMax] by @xAxisMinorStep
      g.add(@line(@sx(x), @sy(@yAxisMin)-2, @sx(x), @sy(@yAxisMin)+2))
    for x in [@xAxisMin..@xAxisMax] by @xAxisMajorStep
      g.add(@line(@sx(x), @sy(@yAxisMin)-4, @sx(x), @sy(@yAxisMin)+4))
      g.add(@text(@sx(x), @sy(@yAxisMin) + 10, x.toString()).withFont('Arial', 10).withStrokeColor('#888'))
    g.add(@text(@sx((@xAxisMin + @xAxisMax) * 0.5), @height - (@margin.bottom * 0.5), @xAxisTitle).withFont('Arial', 12).withStrokeColor('#888'))
    # Y Axis
    g.add(@line(@sx(@xAxisMin), @sy(@yAxisMin), @sx(@xAxisMin), @sy(@yAxisMax)).withStrokeWidth(2))
    for y in [@yAxisMin..@yAxisMax] by @yAxisMinorStep
      g.add(@line(@sx(0)-2, @sy(y), @sx(0)+2, @sy(y)))
    for y in [@yAxisMin..@yAxisMax] by @yAxisMajorStep
      g.add(@line(@sx(@xAxisMin)-4, @sy(y), @sx(@xAxisMin)+4, @sy(y)))
      g.add(@text(@sx(@xAxisMin)-5, @sy(y), y.toString()).withFont('Arial', 10).withStrokeColor('#888').withAnchoring('end'))
    g.add(@text(10, @sy((@yAxisMin + @yAxisMax) * 0.5), @yAxisTitle).withFont('Arial', 12).withStrokeColor('#888').withRotation(-90))
    g

  mask: (opacity = 0.9, color = '#fff') ->
    g = @group("mask")
    g.add(@rectangle(-1, -1, @margin.left, @height + 1).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g.add(@rectangle(@width - @margin.right, -1, @width + 1, @height + 1).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g.add(@rectangle(@margin.left, -1, @width - @margin.right, @margin.top).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g.add(@rectangle(@margin.left, @height - @margin.bottom, @width - @margin.right, @height + 1).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g


root = global ? window
root.suthchart ?= {}
root.suthchart.Chart = Chart
