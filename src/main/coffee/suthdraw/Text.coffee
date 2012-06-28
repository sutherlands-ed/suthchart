class Text extends suthdraw.Element

  type: 'text'
  fontFamily: 'Arial'
  fontSize: 16 # size in pixels
  textAnchor: 'middle' # 'start', 'middle' or 'end'
  strokeColor: '#000'
  rotationAngle: 0
  fontWeight: 'normal'

  constructor: (x, y, text) ->
    @x = x
    @y = y
    @text = text

  withFontSize: (size) ->
    @fontSize = size
    this

  withFontFamily: (family) ->
    @fontFamily = family
    this

  withFont: (family, size) ->
    @fontFamily = family
    @fontSize = size
    this

  withAnchoring: (position) ->
    @textAnchor = position
    this

  withFontWeight: (weight) ->
    @fontWeight = weight
    this

  # textAnchor expressed as a textAlign.
  textAlign: () ->
    switch @textAnchor
      when "start" then "left"
      when "middle" then "center"
      when "end" then "right"
      else ""

window.suthdraw ?= {}
window.suthdraw.Text = Text
