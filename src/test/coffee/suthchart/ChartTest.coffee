root = global ? window

exports.testChart = (test) ->

  c = new suthchart.Chart(1100,1100)
  c.margins(50,50,50,50)

  # Simple axis

  c.linearXAxis("Test", 0, 100, 10, 1)
  test.equal(c.sx(0), 50)
  test.equal(c.sx(100), 1050)

  c.linearYAxis("Test", 0, 100, 10, 1)
  test.equal(c.sy(0), 1050)
  test.equal(c.sy(100), 50)

  # Axis starting after 0

  c.linearXAxis("Test", 100, 200, 10, 1)
  test.equal(c.sx(100), 50)
  test.equal(c.sx(200), 1050)

  c.linearYAxis("Test", 100, 200, 10, 1)
  test.equal(c.sy(100), 1050)
  test.equal(c.sy(200), 50)

  test.done()