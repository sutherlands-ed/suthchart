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

  linearXAxis: (@xAxisTitle, xAxisMin, xAxisMax) ->
    @xAxis = new suthchart.LinearAxis(@xAxisTitle, @width, @margin.left, @margin.right, xAxisMin, xAxisMax, false)
    @xAxisMin = @xAxis.min
    @xAxisMax = @xAxis.max
    @sx = @xAxis.scale
    @rsx = @xAxis.rScale

  linearYAxis: (@yAxisTitle, yAxisMin, yAxisMax) ->
    @yAxis = new suthchart.LinearAxis(@yAxisTitle, @height, @margin.bottom, @margin.top, yAxisMin, yAxisMax, true)
    @yAxisMin = @yAxis.min
    @yAxisMax = @yAxis.max
    @sy = @yAxis.scale
    @rsy = @yAxis.rScale

  grid: () ->
    g = @group("grid")
    # X Grid
    for x in @xAxis.minorSteps
      g.add(@line(@sx(x), @sy(@yAxisMin), @sx(x), @sy(@yAxisMax)).withStrokeWidth(0.1))
    for x in @xAxis.majorSteps
      g.add(@line(@sx(x), @sy(@yAxisMin), @sx(x), @sy(@yAxisMax)).withStrokeWidth(0.2))
    # Y Grid
    for y in @yAxis.minorSteps
      g.add(@line(@sx(@xAxisMin), @sy(y), @sx(@xAxisMax), @sy(y)).withStrokeWidth(0.1))
    for y in @yAxis.majorSteps
      g.add(@line(@sx(@xAxisMin), @sy(y), @sx(@xAxisMax), @sy(y)).withStrokeWidth(0.2))
    g

  axis: () ->
    g = @group("axis")
    # X Axis
    g.add(@line(@sx(@xAxisMin), @sy(@yAxisMin), @sx(@xAxisMax), @sy(@yAxisMin)).withStrokeWidth(2))
    for x in @xAxis.minorSteps
      g.add(@line(@sx(x), @sy(@yAxisMin)-2, @sx(x), @sy(@yAxisMin)+2))
    for x,i in @xAxis.majorSteps
      g.add(@line(@sx(x), @sy(@yAxisMin)-4, @sx(x), @sy(@yAxisMin)+4))
      g.add(@text(@sx(x), @sy(@yAxisMin) + 10, @xAxis.majorLabels[i]).withFont('Arial', 10).withStrokeColor('#888'))
    g.add(@text(@sx((@xAxisMin + @xAxisMax) * 0.5), @height - (@margin.bottom * 0.5), @xAxisTitle).withFont('Arial', 12).withStrokeColor('#888'))
    # Y Axis
    g.add(@line(@sx(@xAxisMin), @sy(@yAxisMin), @sx(@xAxisMin), @sy(@yAxisMax)).withStrokeWidth(2))
    for y in @yAxis.minorSteps
      g.add(@line(@sx(0)-2, @sy(y), @sx(0)+2, @sy(y)))
    for y,i in @yAxis.majorSteps
      g.add(@line(@sx(@xAxisMin)-4, @sy(y), @sx(@xAxisMin)+4, @sy(y)))
      g.add(@text(@sx(@xAxisMin)-5, @sy(y), @yAxis.majorLabels[i]).withFont('Arial', 10).withStrokeColor('#888').withAnchoring('end'))
    g.add(@text(10, @sy((@yAxisMin + @yAxisMax) * 0.5), @yAxisTitle).withFont('Arial', 12).withStrokeColor('#888').withRotation(-90))
    g

  mask: (opacity = 0.9, color = '#fff') ->
    g = @group("mask")
    g.add(@rectangle(-1, -1, @margin.left, @height + 1).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g.add(@rectangle(@width - @margin.right, -1, @width + 1, @height + 1).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g.add(@rectangle(@margin.left, -1, @width - @margin.right, @margin.top).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g.add(@rectangle(@margin.left, @height - @margin.bottom, @width - @margin.right, @height + 1).withStroke(0,'white').withFill(color).withOpacity(opacity))
    g

  strip: (number) -> parseFloat(number.toPrecision(12))

  # Note that this function depends on jQuery!
  enableZoom: (graphElement, redrawFunction) ->
    dragStart = undefined

    graphOffsetX = $(graphElement).offset().left
    graphOffsetY = $(graphElement).offset().top

    eventOffsets = (event) ->
      x = event.pageX - graphOffsetX
      y = event.pageY - graphOffsetY
      [x,y]

    $(graphElement).on('mousedown', (event) ->
      # Record the start point of a drag
      [x,y] = eventOffsets(event)
      dragStart = { x: x, y: y }
    )

    $(graphElement).on('mousemove', (event) ->
      if dragStart?
        [x,y] = eventOffsets(event)
        dx = Math.abs(dragStart.x - x)
        dy = Math.abs(dragStart.y - y)
        # if (dx + dy > 5) then # console.log("Dragging")
      # On windows, the return of false here is essential to prevent elements of the graph looking drag selected
      false
    )

    $(graphElement).on('mouseup', (event) =>
      if dragStart?
        [x,y] = eventOffsets(event)
        dx = Math.abs(dragStart.x - x)
        dy = Math.abs(dragStart.y - y)
        if dx + dy > 5
          dx1 = @rsx(dragStart.x)
          dy1 = @rsy(dragStart.y)
          dx2 = @rsx(x)
          dy2 = @rsy(y)
          x1  = Math.min(dx1,dx2)
          x2  = Math.max(dx1,dx2)
          y1  = Math.min(dy1,dy2)
          y2  = Math.max(dy1,dy2)
          redrawFunction(x1,x2,y1,y2)
          console.log("Drag area: #{dx1},#{dy1} - #{dx2},#{dy2}")
        dragStart = undefined
    )


root = global ? window
root.suthchart ?= {}
root.suthchart.Chart = Chart
