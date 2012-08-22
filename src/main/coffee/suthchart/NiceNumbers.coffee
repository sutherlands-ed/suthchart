class NiceNumbers

  ###
  # Calculate the step size.
  # 
  # @param min
  # @param max
  # @param ntick
  # @param base
  # @param factors
  # @param roundingFactors
  # @return
  ###
  niceNumberStepSize: (min, max, ntick = 5,
                         base = 10,
                         factors = [1, 2, 5],
                         roundingFactors = [[1.5, 1], [3, 2], [7, 5]] ) ->
    delta = nicenum(max - min, usingRounding = false, base = base)
    nicenum(delta / (ntick-1), usingRounding = true, base = base)


  niceNumbers: (min, max, ntick = 5,
                  base = 10,
                  factors = [1, 2, 5],
                  roundingFactors = [[1.5, 1], [3, 2], [7, 5]] ) ->
    step = @niceNumberStepSize(min, max, ntick, base, factors, roundingFactors)
    start = Math.floor(min / step)
    end = Math.ceil(max / step)
    i * step for i in [start..end]


root = global ? window
root.suthchart ?= {}
root.suthchart.NiceNumbers = new NiceNumbers()

# PRIVATE

nicenum = (x, usingRounding, base = 10,
           factors = [1, 2, 5],
           roundingFactors = [[1.5, 1], [3, 2], [7, 5]] ) ->
  step = Math.pow(base, Math.floor(Math.log(x) / Math.log(base)))
  f = x / step
  nf = switch usingRounding
    when true
      match = _.find(roundingFactors, (a) -> f < a[0] )
      if (match) then match[1] else base
    when false
      match = _.find(factors, (a) -> f <= a)
      if (match) then match else base
  nf * step

