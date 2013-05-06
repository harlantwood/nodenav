# 'use strict'
# 
# root = exports ? this  
# 
# class root.NodeTree
#   NOT_A_COLOR = ['Invalid Color Name', 'Invalid Color Name', 'Invalid Color Name']
#   
#   constructor: (@name, @properties) ->
#     throw "ArgumentException" unless typeof @name == "string"
#     throw "ArgumentException" unless @properties instanceof Object
#     @colorize()   
#     
#   to_d3: ->
#     "name": @name
#     "fill_color": @hex_color()
#     "children": 
#       for own property_name, weight of @properties when property_name
#         "name": property_name
#         "size": weight
#                   
#   # sets @color to an array of [R, G, B] values between zero and one
#   colorize: ->
#     @color = [0, 0, 0]
#     for own property_name, weight of @properties when property_name
#       rgb_color = Colors.name2rgb property_name
#       valid_color = ! _.isEqual(rgb_color.a, NOT_A_COLOR)
#       if valid_color           
#         [r, g, b] = rgb_color.a
#         @color[0] += r * weight / 255
#         @color[1] += g * weight / 255
#         @color[2] += b * weight / 255
#     @normalize_color()
#      
#   normalize_color: ->
#     max_component = _.max(@color) 
#     if max_component > 1
#       @color = (component/max_component for component in @color)
# 
#   hex_color: ->
#     Colors.rgb2hex @color_rgb_255()...
# 
#   color_rgb_255: ->
#     Math.round(component * 255) for component in @color
