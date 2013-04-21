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
      for own property_name, property_values of @properties when property_name
        "name": property_name
        "children": 
          for own property_value, weight of property_values
            "name": property_value
            "size": weight
    