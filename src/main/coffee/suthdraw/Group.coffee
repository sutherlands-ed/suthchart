class Group extends suthdraw.Element

  constructor: (@id, @x = 0, @y = 0) ->
    super()
    @type     = 'group'
    @elements = []

  add: (element) ->
    @elements.push(element)

root = global ? window
root.suthdraw ?= {}
root.suthdraw.Group = Group
