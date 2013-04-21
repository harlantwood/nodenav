test "to_d3", -> 
  node_tree = new NodeTree(
    "Joan of Arc",
    "Tags": 
      "Earth Programmer": 0.5,
      "Earth Engineer": 0.6
  )
  
  expected_d3 = 
    {
      "name": "Joan of Arc"
      "children": [
        "name": "Tags"
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
      ]
    }             
    
  deepEqual node_tree.to_d3(), expected_d3 
    
