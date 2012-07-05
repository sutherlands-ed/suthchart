class Text extends suthdraw.Element

  constructor: (@x, @y, @text) ->
    super()
    @type = 'text'
    @fontFamily = 'Arial'
    @fontSize = 16 # size in pixels
    @textAnchor = 'middle' # 'start', 'middle' or 'end'
    @strokeColor = '#000'
    @rotationAngle = 0
    @fontWeight = 'normal'

  withFontSize: (@fontSize) -> @

  withFontFamily: (@fontFamily) -> @

  withFont: (@fontFamily, @fontSize) -> @

  withAnchoring: (@textAnchor) -> @

  withFontWeight: (@fontWeight) -> @

  # textAnchor expressed as a textAlign.
  textAlign: () ->
    switch @textAnchor
      when "start" then "left"
      when "middle" then "center"
      when "end" then "right"
      else ""

window.suthdraw ?= {}
window.suthdraw.Text = Text
