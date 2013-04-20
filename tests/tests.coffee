test "node_trees_to_d3", -> 
  deepEqual node_trees_to_d3(
    {   
      "": 
        "": 
          "Joan of Arc": 0.5
        "Tags":
          "Earth Programmer": 0.5
          "Earth Engineer": 0.5
    }), 
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
            "size": 0.5
          }
        ]
      ]
    }
