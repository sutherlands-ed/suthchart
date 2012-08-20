root = global ? window

niceDates = new suthchart.NiceDates()

exports.testMagnitudes = (test) ->

  d1 = newDate(2012,1,1)
  test.equal(niceDates.SECOND.isDefault(d1), true)
  test.equal(niceDates.SECOND.millis, 1000)

  test.done()

exports.testNiceDateMagnitudeForDateRange = (test) ->

  magnitude = niceDates.niceDateMagnitudeForDateRange(
    newDate(2012, 5, 20, 0, 0), newDate(2012, 6, 12, 0, 0))
  test.equal(magnitude, niceDates.DAY)

  magnitude2 = niceDates.niceDateMagnitudeForDateRange(
    newDate(2012, 1, 1, 0, 0), newDate(2012, 6, 1, 0, 0))
  test.equal(magnitude2, niceDates.MONTH)

  test.done()

exports.testNearestNiceDate = (test) ->

  nearestSecond = niceDates.nearestNiceDate(
    newDate(2012, 5, 20, 12, 36, 28, 766), niceDates.SECOND)
  test.equal(nearestSecond.getTime(), newDate(2012, 5, 20, 12, 36, 29).getTime())

  nearestMinute = niceDates.nearestNiceDate(
    newDate(2012, 5, 20, 12, 36, 28), niceDates.MINUTE)
  test.equal(nearestMinute.getTime(), newDate(2012, 5, 20, 12, 36).getTime())

  nearestHour = niceDates.nearestNiceDate(
    newDate(2012, 5, 20, 12, 36), niceDates.HOUR)
  test.equal(nearestHour.getTime(), newDate(2012, 5, 20, 13, 0).getTime())

  nearestDay = niceDates.nearestNiceDate(
    newDate(2012, 5, 20, 12, 36), niceDates.DAY)
  test.equal(nearestDay.getTime(), newDate(2012, 5, 21, 0, 0).getTime())

  nearestMonth = niceDates.nearestNiceDate(
    newDate(2012, 5, 20, 12, 36), niceDates.MONTH)
  test.equal(nearestMonth.getTime(), newDate(2012, 6, 1, 0, 0).getTime())

  nearestYear = niceDates.nearestNiceDate(
    newDate(2012, 5, 20, 12, 36), niceDates.YEAR)
  test.equal(nearestYear.getTime(), newDate(2012, 1, 1, 0, 0).getTime())

  test.done()

exports.testNiceDateStringForMagnitude = (test) ->
  date = newDate(2012, 5, 20, 12, 36, 29, 766)

  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.MILLISECOND), "20 May 2012, 12:36:29.766")
  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.SECOND), "20 May 2012, 12:36:30")
  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.MINUTE), "20 May 2012, 12:36")
  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.HOUR), "20 May 2012, 1pm")
  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.DAY), "21 May 2012")
  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.MONTH), "Jun 2012")
  test.equal(niceDates.niceDateStringForMagnitude(date, niceDates.YEAR), "2012")

  test.done()

newDate = (year, month = 1, day = 1, hour = 0, minute = 0, second = 0, millisecond = 0) ->
  new Date(year, month - 1, day, hour, minute, second, millisecond)