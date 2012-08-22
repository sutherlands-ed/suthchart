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
      when x then throw error
    [dates, magnitude]


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
        minDate = new Date(date.getUTCFullYear(), date.getMonth(), date.getDate(),
          date.getHours(), date.getMinutes(), date.getSeconds())
        maxDate = minDate.plusSeconds(1)
        [minDate, maxDate]
      when @MINUTE
        minDate = new Date(date.getUTCFullYear(), date.getMonth(), date.getDate(),
          date.getHours(), date.getMinutes())
        maxDate = minDate.plusMinutes(1)
        [minDate, maxDate]
      when @HOUR
        minDate = new Date(date.getUTCFullYear(), date.getMonth(), date.getDate(), date.getHours(), 0)
        maxDate = minDate.plusHours(1)
        [minDate, maxDate]
      when @DAY
        minDate = new Date(date.getUTCFullYear(), date.getMonth(), date.getDate(), 0, 0)
        maxDate = minDate.plusDays(1)
        [minDate, maxDate]
      when @MONTH
        minDate = new Date(date.getUTCFullYear(), date.getMonth(), 1, 0, 0)
        maxDate = minDate.plusMonths(1)
        [minDate, maxDate]
      when @YEAR
        minDate = new Date(date.getUTCFullYear(), 0, 1, 0, 0)
        maxDate = minDate.plusYears(1)
        [minDate, maxDate]
      when x then throw error


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
      when x then throw error


  # def dateStringRelativeToPrevious(previousDate: LocalDateTime, date: LocalDateTime): String = {
  #   val hmcOpt = highestMagnitudeChangeOption(previousDate, date)
  #   val lmcOpt = lowestMagnitudeChangeOption(previousDate, date)
  #   val stringOpt = for {
  #     hmc <- hmcOpt
  #     lmc <- lmcOpt
  #   } yield {
  #     val magnitudes = Magnitude.PRINTING_ORDER.filter(m => hmc >= m && m >= lmc)
  #     dateStringWithMagnitudes(date, magnitudes)
  #   }
  #   stringOpt.getOrElse("''")
  # }

  # def dateStringWithMagnitudes(date: LocalDateTime, magnitudes: Seq[Magnitude]): String = {
  #   // Reorder magnitudes into PRINTING_ORDER and remove all but one entry related to time...
  #   val orderedMags = Magnitude.PRINTING_ORDER.intersect(magnitudes).foldRight(Seq[Magnitude]()){
  #     case (m, Nil) => Seq(m)
  #     case (m, head :: tail) if Magnitude.TIMES.contains(head) && Magnitude.TIMES.contains(m) =>
  #       head :: tail
  #     case (m, head :: tail) => m :: head :: tail
  #   }
  #   val strings = for (m <- orderedMags) yield {
  #     m match {
  #       case Magnitude.MILLISECOND | Magnitude.SECOND | Magnitude.MINUTE | Magnitude.HOUR =>
  #         timeStringForMagnitudes(date, magnitudes)
  #       case Magnitude.DAY => dayStringForMagnitudes(date, magnitudes)
  #       case Magnitude.WEEK => weekStringForMagnitudes(date, magnitudes)
  #       case Magnitude.MONTH => monthStringForMagnitudes(date, magnitudes)
  #       case Magnitude.YEAR => yearStringForMagnitudes(date, magnitudes)
  #       case x => throw new RuntimeException(f"Magnitude of $x not supported!")
  #     }
  #   }
  #   strings.mkString(" ")
  # }

  # private def timeStringForMagnitudes(date: LocalDateTime, magnitudes: Seq[Magnitude]): String = {
  #   val mags = Seq(Magnitude.HOUR, Magnitude.MINUTE, Magnitude.SECOND, Magnitude.MILLISECOND) intersect magnitudes
  #   val strings = for (m <- mags) yield {
  #     m match {
  #       case Magnitude.HOUR =>
  #         if (magnitudes.contains(Magnitude.MINUTE) && !Magnitude.MILLISECOND.isDefault(date)) date.toString("h:")
  #         else date.toString("Ka").toLowerCase
  #       case Magnitude.MINUTE =>
  #         if (magnitudes.contains(Magnitude.HOUR)) {
  #           if (Magnitude.MILLISECOND.isDefault(date)) ""
  #           else date.toString("mm")
  #         } else date.toString("+mm") + "mins"
  #       case Magnitude.SECOND => date.toString("ss")
  #       case Magnitude.MILLISECOND => date.toString("SSS")
  #       case x => throw new RuntimeException(f"Magnitude of $x not supported!")
  #     }
  #   }
  #   strings.mkString + (if (magnitudes.contains(Magnitude.DAY)) " on" else "")
  # }

  # private def dayStringForMagnitudes(date: LocalDateTime, magnitudes: Seq[Magnitude]): String = {
  #   date.toString("d") + (if (!magnitudes.contains(Magnitude.MONTH)) date.toString(" MMM") else "")
  # }

  # private def weekStringForMagnitudes(date: LocalDateTime, magnitudes: Seq[Magnitude]): String = {
  #   date.toString("w")
  # }

  # private def monthStringForMagnitudes(date: LocalDateTime, magnitudes: Seq[Magnitude]): String = {
  #   date.toString("MMM")
  # }

  # private def yearStringForMagnitudes(date: LocalDateTime, magnitudes: Seq[Magnitude]): String = {
  #   date.toString("YYYY")
  # }


  # private def highestMagnitudeChangeOption(date1: LocalDateTime, date2: LocalDateTime): Option[Magnitude] = {
  #   val hmc = if (date1.getYear != date2.getYear) Magnitude.YEAR
  #   else if (date1.getMonthOfYear != date2.getMonthOfYear) Magnitude.MONTH
  #   else if (date1.getDayOfMonth != date2.getDayOfMonth) Magnitude.DAY
  #   else if (date1.getHourOfDay != date2.getHourOfDay) Magnitude.HOUR
  #   else if (date1.getMinuteOfHour != date2.getMinuteOfHour) Magnitude.MINUTE
  #   else if (date1.getSecondOfMinute != date2.getSecondOfMinute) Magnitude.SECOND
  #   else if (date1.getMillisOfSecond != date2.getMillisOfSecond) Magnitude.MILLISECOND
  #   else null
  #   Option(hmc)
  # }


  # private def lowestMagnitudeChangeOption(date1: LocalDateTime, date2: LocalDateTime): Option[Magnitude] = {
  #   val lmc = if (date1.getMillisOfSecond != date2.getMillisOfSecond) Magnitude.MILLISECOND
  #   else if (date1.getSecondOfMinute != date2.getSecondOfMinute) Magnitude.SECOND
  #   else if (date1.getMinuteOfHour != date2.getMinuteOfHour) Magnitude.MINUTE
  #   else if (date1.getHourOfDay != date2.getHourOfDay) Magnitude.HOUR
  #   else if (date1.getDayOfMonth != date2.getDayOfMonth) Magnitude.DAY
  #   else if (date1.getMonthOfYear != date2.getMonthOfYear) Magnitude.MONTH
  #   else if (date1.getYear != date2.getYear) Magnitude.YEAR
  #   else null
  #   Option(lmc)
  # }


  class Magnitude

    constructor: (@name, @millis, @isDefaultFunction) ->
      # Done!

    multiplied: (factor, name, isDefaultFunction) ->
      new Magnitude(name, factor * @millis, isDefaultFunction)

    isDefault: (date) -> @isDefaultFunction(date)

root = global ? window
root.suthchart ?= {}
root.suthchart.NiceDates = NiceDates

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
  d.setUTCFullYear(this.getUTCFullYear() + years)
  d

