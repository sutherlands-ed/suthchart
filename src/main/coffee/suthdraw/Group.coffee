class Group extends suthdraw.Element

  type: 'group'

  elements: []

  constructor: () ->

  add: (element) ->
    @elements.push(element)

window.suthdraw ?= {}
window.suthdraw.Group = Group
