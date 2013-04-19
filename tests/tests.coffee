test "node_trees_to_d3", -> 
  deepEqual node_trees_to_d3(
    {   
      "": 
        "is": [ "Joan of Arc" ] 
        "Tag": [ "Earth Programmer" ] 
      "De-coder and Coder": 
        "Tag": [ "Earth Programmer" ] 
    }), 
    {
      "name": "Joan of Arc"
      "children": [
        "name": "Tag"
        "children": [
          "name": "Earth Programmer",
          "size": 3  
        ]
      ]
    }
