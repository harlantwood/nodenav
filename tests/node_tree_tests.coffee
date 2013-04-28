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
    
test "color when no color information is present", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Earth Programmer": 1,
  )
  equal node_tree.color(), '#000000'

test "color it black", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Black": 1,
  )
  equal node_tree.color(), '#000000'

test "color it red", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Red": 1
  )
  equal node_tree.color(), '#ff0000'

test "color it blue", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Blue": 1
  )
  equal node_tree.color(), '#0000ff'

test "color it purple (mixing red and blue)", ->
  node_tree = new NodeTree(
    "Joan of Arc",
    "Blue": 1
    "Red": 1
  )
  equal node_tree.color(), '#ff00ff'

