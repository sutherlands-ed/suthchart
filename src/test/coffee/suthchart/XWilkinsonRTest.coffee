root = global ? window

exports.testXWilkinsonR = (test) ->

  r = root.suthchart.XWilkinsonR.extended(-98.0, 18.0, 3, onlyLoose = true)
  test.deepEqual(r, [-100.0, 20.0, 60.0, 0.3125683709869203])


  r = root.suthchart.XWilkinsonR.extended(-98.0, 18.0, 3)
  test.deepEqual(r, [-100.0,0.0,50.0,0.36530321046373376])

  r = root.suthchart.XWilkinsonR.extended(-1.0, 200.0, 3, onlyLoose = true)
  test.deepEqual(r, [-25.0,200.0,75.0,-0.14821341055914455])
  r = root.suthchart.XWilkinsonR.extended(-1.0, 200.0, 3)
  test.deepEqual(r, [0.0,200.0,100.0,0.7971906017177792])

  r = root.suthchart.XWilkinsonR.extended(119.0, 178.0, 3, onlyLoose = true)
  test.deepEqual(r, [116.0,180.0,16.0,-0.5066819879345015])
  r = root.suthchart.XWilkinsonR.extended(119.0, 178.0, 3)
  test.deepEqual(r, [120.0,180.0,30.0,0.5737120559226276])

  r = root.suthchart.XWilkinsonR.extended(-31.0, 27.0, 5, onlyLoose = true)
  test.deepEqual(r, [-32.0,28.0,12.0,0.10756837098692036])
  r = root.suthchart.XWilkinsonR.extended(-31.0, 27.0, 5)
  test.deepEqual(r, [-30.0,30.0,10.0,0.5003418549346017])

  r = root.suthchart.XWilkinsonR.extended(-55.45, -49.99, 2, onlyLoose = true)
  test.deepEqual(r, [-55.5,-49.5,3.0,-0.8417221484254458 ])
  r = root.suthchart.XWilkinsonR.extended(-55.45, -49.99, 3)
  test.deepEqual(r, [-55.0,-50.0,2.5,0.5490498463685265])

  r = root.suthchart.XWilkinsonR.extended(0, 100, 2)
  test.deepEqual(r, [0.0,100.0,100.0,0.8])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 3)
  test.deepEqual(r, [0.0,100.0,50.0,0.76])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 4)
  test.deepEqual(r, [0.0,100.0,25.0,0.5133333333333333])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 5)
  test.deepEqual(r, [0.0,100.0,25.0,0.68])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 6)
  test.deepEqual(r, [0.0,100.0,20.0,0.72])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 7)
  test.deepEqual(r, [0.0,100.0,20.0,0.6200000000000001])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 8)
  test.deepEqual(r, [0.0,100.0,10.0,0.5857142857142857])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 9)
  test.deepEqual(r, [0.0,100.0,10.0,0.675 ])
  r = root.suthchart.XWilkinsonR.extended(0, 100, 10)
  test.deepEqual(r, [0.0,100.0,10.0,0.7444444444444445])


  test.done()
