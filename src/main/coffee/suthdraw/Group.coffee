class Group extends suthdraw.Element

  constructor: (@id) ->
    super()
    @type = 'group'
    @elements = []

  add: (element) ->
    @elements.push(element)

window.suthdraw ?= {}
window.suthdraw.Group = Group
