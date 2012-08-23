root = global ? window
root.suthchart ?= {}

class Axis

  ###
  # @param reverse whether the axis should be reversed.  Normally an x axis is not reversed, but a y axis
  #    is, because the y axis increases going up the way on the screen.
  ###
  constructor: (@title, @spaceLengthPx, @startMarginPx, @endMarginPx, @min, @max, @reverse = false) ->
    if (min >= max) then throw Error("Minimum must be smaller than maximum for axis!")
    @axisLengthPx = @spaceLengthPx - @startMarginPx - @endMarginPx
    @axisLength = @max - @min
    @scaleFactor = @axisLengthPx / @axisLength
    @reverseScaleFactor = @axisLength / @axisLengthPx
    if (!@reverse)
      @scale = (x) => (x - @min) * @scaleFactor + @startMarginPx
      @rScale = (xPx) => (xPx - @startMarginPx) * @reverseScaleFactor + @min
    else
      @scale = (x) => @endMarginPx + @axisLengthPx - (x - @min) * @scaleFactor
      @rScale = (xPx) => (@axisLengthPx - (xPx - @endMarginPx)) * @reverseScaleFactor + @min

root.suthchart.Axis = Axis

class LinearAxis extends Axis

  constructor: (@title, @spaceLengthPx, @startMarginPx, @endMarginPx, min, max, @reverse = false) ->
    [@min, @max, @majorStep, score] = suthchart.XWilkinsonR.extended(min, max, 5, true)
    console.log("@min = #{@min}, @max = #{@max}")
    @minorStep = @majorStep / 10
    super(@title, @spaceLengthPx, @startMarginPx, @endMarginPx, @min, @max, @reverse)

    @majorSteps = (x for x in [@min..@max] by @majorStep)
    @minorSteps = (x for x in [@min..@max] by @minorStep)
    @majorLabels = for x in @majorSteps
      parseFloat(x.toPrecision(12)).toString()

root.suthchart.LinearAxis = LinearAxis

class DateAxis extends Axis

root.suthchart.DateAxis = DateAxis
