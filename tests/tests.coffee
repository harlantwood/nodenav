test "node_trees_to_d3, default view", -> 
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

test "node_trees_to_d3, specified view", -> 
  deepEqual node_trees_to_d3(
    {   
      "Consultant":
        "type": 
          "Title": 0.5
        "Tags": 
          "Contracter": 0.5
    }, "Consultant"), 
    {
      "name": "Consultant"
      "children": [
        {
          "name": "type"
          "children": [            
            {
              "name": "Title"
              "size": 0.5
            }
          ]
        }
        {
          "name": "Tags"
          "children": [            
            {
              "name": "Contracter"
              "size": 0.5
            }
          ]
        }
      ]
    }
