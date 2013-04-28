test "to_d3", -> 
  node_tree = new NodeTree(
    "Joan of Arc",
    "Earth Programmer": 0.5,
    "Earth Engineer": 0.6
  )
  
  expected_d3 = 
    {
      "name": "Joan of Arc"
      "children": [
        {
          "name": "Earth Programmer"
          "size": 0.5
        }
        {
          "name": "Earth Engineer"
          "size": 0.6
        }
      ]
    }             
    
  deepEqual node_tree.to_d3(), expected_d3 
    
test "hex_color when no color information is present", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Earth Programmer": 1,
  )
  equal node_tree.hex_color(), '#000000'

test "hex_color it black", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Black": 1,
  )
  equal node_tree.hex_color(), '#000000'

test "hex_color it red", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 1
  )
  equal node_tree.hex_color(), '#ff0000'

test "hex_color it blue", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Blue": 1
  )
  equal node_tree.hex_color(), '#0000ff'

test "hex_color it purple (mixing red and blue)", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Blue": 1
    "Red": 1
  )
  equal node_tree.hex_color(), '#ff00ff'

test "hex_color mixing and normalization", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 1
    "Purple": 1 
  )
  equal node_tree.hex_color(), '#ff0055'
  
test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 0.5
    "green": 0
  )
  equal node_tree.hex_color(), '#800000'

test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 1
    "green": 0
  )
  equal node_tree.hex_color(), '#ff0000'

test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 2
    "green": 0
  )
  equal node_tree.hex_color(), '#ff0000'

test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "red": 1
    "blue": 1
  )
  equal node_tree.hex_color(), '#ff00ff'

test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 2
    "Blue": 1
  )
  equal node_tree.hex_color(), '#ff0080'

test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "red": 4
    "blue": 1
  )
  equal node_tree.hex_color(), '#ff0040'

test "hex_color weights", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "red": 0.5
    "blue": 1/3 
  )
  equal node_tree.hex_color(), 'NOT #800055'
