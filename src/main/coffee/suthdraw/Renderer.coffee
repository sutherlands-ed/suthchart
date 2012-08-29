class Renderer

  # OBJECT FUNCTIONS

  @idIfSet: (element) ->
    if (!element.id? || element.id == "") then " " else "data-id=\"#{element.id}\" "

  @style: (element, addition = null) ->
    styles = []
    if (element.style? && element.style.length > 0)
      styles.push(element.style)
    if (addition? && addition.length > 0)
      styles.push(addition)
    if (element.cursor?)
      styles.push("cursor:#{element.cursor}")
    if (element.hidden ? false) == true
      styles.push('display:none')
    if styles.length > 0
      "style=\"#{styles.join(';')}\" "
    else
      " "

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Renderer = Renderer

