root = exports ? this  

class root.NodeTree
  NOT_A_COLOR = ['Invalid Color Name', 'Invalid Color Name', 'Invalid Color Name']
  
  constructor: (@name, @properties) ->
    throw "ArgumentException" unless typeof @name == "string"
    throw "ArgumentException" unless @properties instanceof Object
    @color = [0, 0, 0]   # RGB values between zero and one
    
  to_d3: ->
    "name": @name
    "children": 
      for own property_name, weight of @properties when property_name
        "name": property_name
        "size": weight
        
  hex_color: ->
    for own property_name, weight of @properties when property_name
      rgb_color = Colors.name2rgb property_name
      valid_color = ! _.isEqual(rgb_color.a, NOT_A_COLOR)
      if valid_color           
        [r, g, b] = rgb_color.a
        @color[0] += r/255
        @color[1] += g/255
        @color[2] += b/255
    @normalize_color()
    Colors.rgb2hex @color_rgb_255()...

  normalize_color: ->
    max_component = _.max(@color) 
    if max_component > 1
      @color = for component in @color
        component/max_component

  color_rgb_255: ->
    for component in @color
      Math.round(component * 255)
