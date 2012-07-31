class Renderer

  # OBJECT FUNCTIONS

  @idIfSet: (element) ->
    if (element.id == "") then "" else "data-id=\"#{element.id}\""

  @style: (element) ->
    if (element.hidden ? false) == true
      'style="display:none" '
    else ''

  @styleAddition: (element) ->
    if (element.hidden ? false) == true
      ';display:none'
    else ''


root = global ? window
root.suthdraw ?= {}
root.suthdraw.Renderer = Renderer

