class Chart extends suthdraw.Drawing

  title: (title) ->
    @text(@width / 2, 20, title).withFont('Arial', 16).withStrokeColor('#555')

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
    # TODO: Add code to add grid within a group.

  axis: () ->
    # TODO: Add code to add axis within a group.

window.suthchart ?= {}
window.suthchart.Chart = Chart
