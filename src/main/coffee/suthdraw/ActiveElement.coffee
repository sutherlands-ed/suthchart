class ActiveElement

  addClass: (className) ->
    c = @element.getAttribute('class').split(' ')
    c.push(className)
    @element.setAttribute('class', c.join(' '))
    this

  removeClass: (className) ->
    classes = @element.getAttribute('class').split(' ')
    newClasses = classes.filter( (x) -> x != className )
    @element.setAttribute('class', newClasses.join(' '))
    this

  constructor: (element) ->
    @element = element
    c = element.attributes.class.nodeValue
    match = c.match(///sd\-.+///)?[0]
    if match?
      @type = match.substring(3)
    @id = Number(element.getAttribute('data-id'))


window.suthdraw ?= {}
window.suthdraw.ActiveElement = ActiveElement
