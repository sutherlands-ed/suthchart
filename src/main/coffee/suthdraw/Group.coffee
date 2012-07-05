class Group extends suthdraw.Element

  constructor: (@id, @x = 0, @y = 0) ->
    super()
    @type = 'group'
    @elements = []

  add: (element) ->
    @elements.push(element)

window.suthdraw ?= {}
window.suthdraw.Group = Group
