root = global ? window

niceNumbers = suthchart.NiceNumbers

exports.testNiceNumbersStepSize = (test) ->

  test.equal(niceNumbers.niceNumberStepSize(0, 1), 0.2)
  test.equal(niceNumbers.niceNumberStepSize(0, 2), 0.5)
  test.equal(niceNumbers.niceNumberStepSize(0, 3), 1)
  test.equal(niceNumbers.niceNumberStepSize(0, 4), 1)
  test.equal(niceNumbers.niceNumberStepSize(0, 5), 1)
  test.equal(niceNumbers.niceNumberStepSize(0, 6), 2)
  test.equal(niceNumbers.niceNumberStepSize(0, 7), 2)
  test.equal(niceNumbers.niceNumberStepSize(0, 8), 2)
  test.equal(niceNumbers.niceNumberStepSize(0, 9), 2)
  test.equal(niceNumbers.niceNumberStepSize(0, 10), 2)

  test.equal(niceNumbers.niceNumberStepSize(0, 100), 20)
  test.equal(niceNumbers.niceNumberStepSize(0, 45), 10)
  test.equal(niceNumbers.niceNumberStepSize(1000, 1005), 1)
  test.equal(niceNumbers.niceNumberStepSize(65, 89), 10)
  test.equal(niceNumbers.niceNumberStepSize(-200, 10), 100)

  test.equal(niceNumbers.niceNumberStepSize(-200, 10, ntick = 10), 50)
  test.equal(niceNumbers.niceNumberStepSize(-200, 10, ntick = 15), 50)
  test.equal(niceNumbers.niceNumberStepSize(-200, 10, ntick = 20), 20)

  test.done()

exports.testNiceNumbers = (test) ->

  test.deepEqual(niceNumbers.niceNumbers(65, 89), [60,70,80,90])
  test.deepEqual(niceNumbers.niceNumbers(-212, 89), [-300,-200,-100,0,100])

  test.done()