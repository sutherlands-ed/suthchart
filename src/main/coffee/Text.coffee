class Text extends suthchart.Element

  type: 'text'
  fontFamily: 'Arial'
  fontSize: 16
  textAnchor: 'middle'
  strokeColor: '#000'

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

window.suthchart ?= {}
window.suthchart.Text = Text
