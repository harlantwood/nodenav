root = exports ? this  

class root.NodeTree
  NOT_A_COLOR = ['Invalid Color Name', 'Invalid Color Name', 'Invalid Color Name']
  
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
    colors = [[0,0,0]]
    for own property_name, weight of @properties when property_name
      rgb_color = Colors.name2rgb property_name
      colors.push rgb_color.a unless _.isEqual(rgb_color.a, NOT_A_COLOR)
    mixed_color = for color_flock in _.zip(colors...)
      _.reduce(color_flock, ((memo, num) -> (memo + parseInt num)), 0)
    Colors.rgb2hex mixed_color...
