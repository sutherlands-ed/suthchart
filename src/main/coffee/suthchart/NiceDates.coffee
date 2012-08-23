class NiceDates

  constructor: () ->
    @MILLISECOND = new Magnitude("MILLISECOND", 1, (date) -> date.getMilliseconds() == 0)
    @SECOND      = @MILLISECOND.multiplied(1000, "SECOND", (date) -> date.getSeconds() == 0)
    @MINUTE      = @SECOND.multiplied(60, "MINUTE", (date) -> date.getMinutes() == 0)
    @HOUR        = @MINUTE.multiplied(60, "HOUR", (date) -> date.getHours() == 0)
    @DAY         = @HOUR.multiplied(24, "DAY", (date) -> date.getDate() == 1)
    # @WEEK       = @DAY.multiplied(7, "WEEK", (date) -> date.getWeeks() == 0)
    @MONTH       = @DAY.multiplied(30, "MONTH", (date) -> date.getMonth() == 0)
    @YEAR        = @DAY.multiplied(365, "YEAR", (date) -> false)

    @STANDARD_DECREASING  = [@YEAR, @MONTH, @DAY, @HOUR, @MINUTE, @SECOND, @MILLISECOND]
    @PRINTING_ORDER       = [@HOUR, @MINUTE, @SECOND, @MILLISECOND, @DAY, @MONTH, @YEAR]
    @TIMES                = [@HOUR, @MINUTE, @SECOND, @MILLISECOND]


  niceRange: (startDate, endDate) ->
    magnitude = @niceDateMagnitudeForDateRange(startDate, endDate)
    [niceStartDate, _] = @bracketingNiceDates(startDate, magnitude)
    [_, niceEndDate] = @bracketingNiceDates(endDate, magnitude)
    [niceStartDate, niceEndDate, magnitude]


  niceDates: (startDate, endDate) ->
    console.log("startDate = #{startDate}, endDate = #{endDate}")
    [niceStartDate, niceEndDate, magnitude] = @niceRange(startDate, endDate)
    dates = switch magnitude
      when @MILLISECOND, @MINUTE, @HOUR, @DAY
        start = niceStartDate.getTime() / magnitude.millis
        end = niceEndDate.getTime() / magnitude.millis
        numbers = suthchart.NiceNumbers.niceNumbers(start, end)
        new Date(n * magnitude.millis) for n in numbers
      when @MONTH
        start = niceStartDate.getFullYear() * 12 + niceStartDate.getMonth()
        end = niceEndDate.getFullYear() * 12 + niceEndDate.getMonth()
        numbers = suthchart.NiceNumbers.niceNumbers(start, end)
        new Date(Math.floor(n / 12), (n % 12), 1, 0, 0) for n in numbers
      when @YEAR
        start = niceStartDate.getFullYear()
        end = niceEndDate.getFullYear()
        numbers = suthchart.NiceNumbers.niceNumbers(start, end)
        new Date(n, 1, 1, 0, 0) for n in numbers
      else throw Error("Magnitude not handled!")
    [dates, magnitude]


  niceLabels: (dates) ->
    firstDate = dates[0]
    firstMags = _.chain(@STANDARD_DECREASING).reverse().dropWhile( (x) ->
      x.isDefault(firstDate)
    ).value()
    first = @dateStringWithMagnitudes(firstDate, firstMags)
    [first].concat(_.chain(dates).sliding(2).map( (d) =>
      @dateStringRelativeToPrevious(d[0], d[1])
    ).value())


  niceDateMagnitudeForDateRange: (startDate, endDate) ->
    diff = Math.abs(endDate.getTime() - startDate.getTime())
    if (diff < @SECOND.millis) then @MILLISECOND
    else if (diff < @MINUTE.millis) then @SECOND
    else if (diff < @HOUR.millis) then @MINUTE
    else if (diff < @DAY.millis) then @HOUR
    # else if (diff < @WEEK.millis) then @DAY
    else if (diff < @MONTH.millis) then @DAY
    else if (diff < @YEAR.millis) then @MONTH
    else @YEAR


  ###
  # Given a date and lowest date magnitude, return the nearest nice date.
  # 
  # @param date the datetime to approximate to.
  # @param magnitude the lowest magnitude of the date you require, e.g. hours, minutes.
  # @return a nice approximation to the date.
  ###
  nearestNiceDate: (date, magnitude) ->
    millis = date.getTime()
    [minDate, maxDate] = @bracketingNiceDates(date, magnitude)
    minDiff = Math.abs(minDate.getTime() - millis)
    maxDiff = Math.abs(maxDate.getTime() - millis)
    if (minDiff < maxDiff) then minDate else maxDate


  ###
  # Given a date and lowest date magnitude, return the nearest nice date before and after the date.
  # 
  # @param date the datetime to approximate to.
  # @param magnitude the lowest magnitude of the date you require, e.g. hours, minutes.
  # @return a tuple containing a nice date proceeding and following the given date.
  ###
  bracketingNiceDates: (date, magnitude) ->
    switch magnitude
      when @MILLISECOND
        [date, date]
      when @SECOND
        minDate = new Date(date.getFullYear(), date.getMonth(), date.getDate(),
          date.getHours(), date.getMinutes(), date.getSeconds())
        maxDate = minDate.plusSeconds(1)
        [minDate, maxDate]
      when @MINUTE
        minDate = new Date(date.getFullYear(), date.getMonth(), date.getDate(),
          date.getHours(), date.getMinutes())
        maxDate = minDate.plusMinutes(1)
        [minDate, maxDate]
      when @HOUR
        minDate = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), 0)
        maxDate = minDate.plusHours(1)
        [minDate, maxDate]
      when @DAY
        minDate = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0)
        maxDate = minDate.plusDays(1)
        [minDate, maxDate]
      when @MONTH
        minDate = new Date(date.getFullYear(), date.getMonth(), 1, 0, 0)
        maxDate = minDate.plusMonths(1)
        [minDate, maxDate]
      when @YEAR
        minDate = new Date(date.getFullYear(), 0, 1, 0, 0)
        maxDate = minDate.plusYears(1)
        [minDate, maxDate]
      else throw Error("Magnitude not handled!")


  ###
  # Return a String representing a nice date approximating the given date to the order of magnitude specified.
  #
  # @param date the datetime to approximate to.
  # @param magnitude the lowest magnitude of the date you require, e.g. hours, minutes.
  # @return the approximate nice date as a String.
  ###
  niceDateStringForMagnitude: (date, magnitude) ->
    nearest = @nearestNiceDate(date, magnitude)
    switch magnitude
      when @MILLISECOND
        nearest.format("d mmm yyyy, hh:MM:ss.l")
      when @SECOND
        nearest.format("d mmm yyyy, hh:MM:ss")
      when @MINUTE
        nearest.format("d mmm yyyy, hh:MM")
      when @HOUR
        nearest.format("d mmm yyyy, htt")
      when @DAY
        nearest.format("d mmm yyyy")
      when @WEEK
        nearest.format("w")
      when @MONTH
        nearest.format("mmm yyyy")
      when @YEAR
        nearest.format("yyyy")
      else throw Error("Magnitude not handled!")


  dateStringRelativeToPrevious: (previousDate, date) ->
    hmc = @highestMagnitudeChangeOption(previousDate, date)
    lmc = @lowestMagnitudeChangeOption(previousDate, date)
    if (hmc? && lmc?)
      magnitudes = _.filter(@PRINTING_ORDER, (m) -> hmc.millis >= m.millis && m.millis >= lmc.millis)
      @dateStringWithMagnitudes(date, magnitudes)
    else ''

  dateStringWithMagnitudes: (date, magnitudes) ->
    # Reorder magnitudes into PRINTING_ORDER and remove all but one entry related to time...
    orderedMags = _.chain(@PRINTING_ORDER).intersection(magnitudes).map( (m) =>
      switch m
        when @MILLISECOND, @SECOND, @MINUTE, @HOUR then @MILLISECOND
        else m
    ).uniq(true).value()
    strings = for m in orderedMags
      switch m
        when @MILLISECOND
          @timeStringForMagnitudes(date, magnitudes)
        when @DAY then @dayStringForMagnitudes(date, magnitudes)
        when @WEEK then @weekStringForMagnitudes(date, magnitudes)
        when @MONTH then @monthStringForMagnitudes(date, magnitudes)
        when @YEAR then @yearStringForMagnitudes(date, magnitudes)
        else throw Error("Magnitude not handled!")
    strings.join(" ")

  timeStringForMagnitudes: (date, magnitudes) ->
    mags = _.intersection([@HOUR, @MINUTE, @SECOND, @MILLISECOND], magnitudes)
    strings = for m in mags
      switch m
        when @HOUR
          if (_.contains(magnitudes, @MINUTE) && !@MILLISECOND.isDefault(date)) then date.format("hh:")
          else date.format("htt").toLowerCase()
        when @MINUTE
          if (_.contains(magnitudes, @HOUR))
            if (@MINUTE.isDefault(date)) then ""
            else date.format("MM")
          else date.format("+MM") + "mins"
        when @SECOND then date.format("ss")
        when @MILLISECOND then date.format("l")
        else throw Error("Magnitude not handled!")
    strings.join('') + (if (_.contains(magnitudes, @DAY)) then " on" else "")

  dayStringForMagnitudes: (date, magnitudes) ->
    date.format("d") + (if (!_.contains(magnitudes, @MONTH)) then date.format(" mmm") else "")

  weekStringForMagnitudes: (date, magnitudes) ->
    date.format("w")

  monthStringForMagnitudes: (date, magnitudes) ->
    date.format("mmm")

  yearStringForMagnitudes: (date, magnitudes) ->
    date.format("yyyy")


  highestMagnitudeChangeOption: (date1, date2) ->
    if (date1.getFullYear() != date2.getFullYear()) then @YEAR
    else if (date1.getMonth() != date2.getMonth()) then @MONTH
    else if (date1.getDate() != date2.getDate()) then @DAY
    else if (date1.getHours() != date2.getHours()) then @HOUR
    else if (date1.getMinutes() != date2.getMinutes()) then @MINUTE
    else if (date1.getSeconds() != date2.getSeconds()) then @SECOND
    else if (date1.getMilliseconds() != date2.getMilliseconds()) then @MILLISECOND
    else undefined


  lowestMagnitudeChangeOption: (date1, date2) ->
    if (date1.getMilliseconds() != date2.getMilliseconds()) then @MILLISECOND
    else if (date1.getSeconds() != date2.getSeconds()) then @SECOND
    else if (date1.getMinutes() != date2.getMinutes()) then @MINUTE
    else if (date1.getHours() != date2.getHours()) then @HOUR
    else if (date1.getDate() != date2.getDate()) then @DAY
    else if (date1.getMonth() != date2.getMonth()) then @MONTH
    else if (date1.getFullYear() != date2.getFullYear()) then @YEAR
    else undefined


  class Magnitude

    constructor: (@name, @millis, @isDefaultFunction) ->
      # Done!

    multiplied: (factor, name, isDefaultFunction) ->
      new Magnitude(name, factor * @millis, isDefaultFunction)

    isDefault: (date) -> @isDefaultFunction(date)

    toString: () -> @name

    equals: (other) -> @name == other.name

root = global ? window
root.suthchart ?= {}
root.suthchart.NiceDates = new NiceDates()

# Add JodaTime like functionality to the built in Date object

Date::plusMilliseconds ||= (milliseconds) ->
  d = new Date(this)
  d.setMillimilliseconds(this.getMillimilliseconds() + milliseconds)
  d
Date::plusSeconds ||= (seconds) ->
  d = new Date(this)
  d.setSeconds(this.getSeconds() + seconds)
  d
Date::plusMinutes ||= (minutes) ->
  d = new Date(this)
  d.setMinutes(this.getMinutes() + minutes)
  d
Date::plusHours ||= (hours) ->
  d = new Date(this)
  d.setHours(this.getHours() + hours)
  d
Date::plusDays ||= (days) ->
  d = new Date(this)
  d.setDate(this.getDate() + days)
  d
Date::plusMonths ||= (months) ->
  d = new Date(this)
  d.setMonth(this.getMonth() + months)
  d
Date::plusYears ||= (years) ->
  d = new Date(this)
  d.setUTCFullYear(this.getFullYear() + years)
  d

# Add extra functions to underscore.js and fix issue with reverse mutating the original array.

_.mixin({
    dropWhile: (array, f) ->
      match = _.find(array, (x) -> !f(x))
      if (match)
        indexOfMatch = array.indexOf(match)
        array.slice(indexOfMatch)
      else []
    sliding: (array, window) ->
      end = array.length - window
      array[i..(i+window-1)] for i in [0..end]
    reverse: (array) ->
      array.slice().reverse()
  })


