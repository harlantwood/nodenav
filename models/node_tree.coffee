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
        
  color: ->
    colors = []
    for own property_name, weight of @properties when property_name
      rgb_color = Colors.name2rgb property_name
      colors.push rgb_color.a unless rgb_color == "Invalid Color Name"
    mixed_color = for color_flock in _.zip(colors...)
      _.reduce(color_flock, ((memo, num) -> (memo + parseInt num)), 0)
    Colors.rgb2hex mixed_color...
