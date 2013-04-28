root = exports ? this  

class root.NodeTree
  constructor: (@name, @properties) ->
    throw "ArgumentException" unless typeof @name == "string"
    throw "ArgumentException" unless @properties instanceof Object
    # this[''] = @name
    # for own key, value in @properties when key
    #   this[key] = value
    
  to_d3: ->
    "name": @name
    "children": 
      for own property_name, weight of @properties when property_name
        "name": property_name
        "size": weight    