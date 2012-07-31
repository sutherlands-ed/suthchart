class XWilkinsonR

  constructor: () ->
    # Calculate Machine Epsilon for this browser...
    @epsilon = 1.0
    while ((1 + (@epsilon/2)) != 1)
      @epsilon /= 2


  ###
  # An Extension of Wilkinson's Algorithm for Position Tick Labels on Axes
  #
  # Enhanced version of Wilkinson's optimization-based axis labeling approach. It is described in detail in our paper.
  # Talbot, J., Lin, S., Hanrahan, P. (2010) An Extension of Wilkinson's Algorithm for Positioning Tick Labels on Axes,
  # InfoVis 2010.
  #
  # Conversion to CoffeeScript by Stuart Roebuck, 2012.
  #
  # @param dmin minimum of the data range
  # @param dmax maximum of the data range
  # @param m number of axis labels required
  # @param Q set of nice numbers
  # @param onlyLoose if true, the extreme labels will be outside the data range
  # @param w weights applied to the four optimization components (simplicity, coverage, density, and legibility)
  # @return vector of axis label locations
  #
  # @author Justin Talbot jtalbot@stanford.edu
  # @author Stuart Roebuck stuart.roebuck@gmail.com
  ###
  @extended: (dmin, dmax, m, onlyLoose = false, Q = [1,5,2,2.5,4,3], w = {
   simplicity: 0.2, coverage: 0.25, density: 0.5, legibility: 0.05
  }) ->

    score = (simplicity, coverage, density, legibility) ->
      w.simplicity * simplicity + w.coverage * coverage + w.density * density + w.legibility * legibility

    bestLmin = 0.0
    bestLmax = 0.0
    bestLstep = 0.0
    bestScore = -2.0

    eps = @epsilon

    [min,max] = (if (dmin > dmax) then [dmax,dmin] else [dmin,dmax])

    if (dmax - dmin < eps)
      # if the range is near the floating point limit, let seq generate some equally spaced steps.
      [min, max, m, -2]
    else
      length = Q.length
      j = -1.0
      while (j < Number.POSITIVE_INFINITY)
        for qi in [0..(length - 1)]
          q = Q[qi]
          sm = XWilkinsonR.simplicityMax(qi, length, j)

          if (score(sm, 1, 1, 1) < bestScore)
            j = Number.POSITIVE_INFINITY
            # break
          else

            k = 2.0
            while (k < Number.POSITIVE_INFINITY) # loop over tick counts

              dm = XWilkinsonR.densityMax(k, m)

              if (score(sm, 1, dm, 1) < bestScore)
                k = Number.POSITIVE_INFINITY
                # break
              else

                delta = (max - min) / (k + 1) / j / q
                z = Math.ceil(Math.log(delta) * XWilkinsonR.ONE_OVER_LOG_10) # base = 10

                while (z < Number.POSITIVE_INFINITY)

                  step = j * q * Math.pow(10,z)

                  cm = XWilkinsonR.coverageMax(min, max, step * (k - 1))

                  if (score(sm, cm, dm, 1) < bestScore)
                    z = Number.POSITIVE_INFINITY
                    # break
                  else
                    minStart = Math.floor(max / step) * j - (k - 1) * j
                    maxStart = Math.ceil(min / step) * j

                    if (minStart > maxStart)
                      # next
                    else
                      for start in [minStart..maxStart]
                        lmin = start * (step / j)
                        lmax = lmin + step * (k - 1)

                        if (!onlyLoose || (lmin <= min && lmax >= max))
                          s = XWilkinsonR.simplicity(qi, length, j, lmin, lmax, step)
                          c = XWilkinsonR.coverage(min, max, lmin, lmax)
                          g = XWilkinsonR.density(k, m, min, max, lmin, lmax)
                          l = XWilkinsonR.legibility(lmin, lmax, step)

                          thisScore = score(s, c, g, l)
                          if (thisScore > bestScore)
                            bestScore = thisScore
                            bestLmin = lmin
                            bestLmax = lmax
                            bestLstep = step
                    z += 1
              k += 1
        j += 1
      [bestLmin, bestLmax, bestLstep, bestScore]


  # OBJECT FUNCTIONS

  @ONE_OVER_LOG_10: 1 / Math.log(10)

  @simplicity: (i, n, j, lmin, lmax, lstep) ->
    v = if (((lmin % lstep) < @epsilon || (lstep - (lmin % lstep)) < @epsilon) && lmin <= 0 && lmax >= 0) then 1 else 0
    1 - ( i / (n - 1) ) - j + v

  @simplicityMax: (i, n, j) ->
    1 - i / (n-1) - j + 1

  @coverage: (dmin, dmax, lmin, lmax) ->
    range = dmax - dmin
    1 - 0.5 * (Math.pow(dmax-lmax,2) + Math.pow(dmin-lmin,2)) / (Math.pow(0.1*range,2))

  @coverageMax: (dmin, dmax, span) ->
    range = dmax - dmin
    if (span > range)
      half = (span - range) / 2
      1 - 0.5 * (Math.pow(half,2) + Math.pow(half,2)) / (Math.pow(0.1 * range,2))
    else
      1

  @density: (k, m, dmin, dmax, lmin, lmax) ->
    r = (k - 1) / (lmax - lmin)
    rt = (m - 1) / (Math.max(lmax,dmax) - Math.min(dmin,lmin))
    2 - Math.max(r / rt, rt / r)

  @densityMax: (k, m) ->
    if (k >= m)
      2 - (k - 1) / (m - 1)
    else
      1

  @legibility: (lmin, lmax, lstep) ->
    1.0 # converted from R code which doesn't implement this method!

root = global ? window
root.suthchart ?= {}
root.suthchart.XWilkinsonR = XWilkinsonR

