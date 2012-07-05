class ActiveElement

  constructor: (@element) ->
    c = element.attributes.class.nodeValue
    match = c.match(///sd\-.+///)?[0]
    if match?
      @type = match.substring(3)
    @id = Number(element.getAttribute('data-id'))

  addClass: (className) ->
    c = @getClasses()
    c.push(className)
    @setClasses(c)
    @

  removeClass: (className) ->
    classes = @getClasses()
    newClasses = (x for x in classes when x != className)
    @setClasses(newClasses)
    @

  getClasses: () ->
    c = @element.className
    if (typeof c == "string")
      c.split(' ')
    else
      @element.getAttribute('class').split(' ')

  setClasses: (classes) ->
    c = @element.className
    classesString = if classes?
      classes.join(' ')
    else
      null
    if (typeof c == "string")
      @element.className = classesString
    else
      @element.setAttribute('class', classesString)


window.suthdraw ?= {}
window.suthdraw.ActiveElement = ActiveElement
