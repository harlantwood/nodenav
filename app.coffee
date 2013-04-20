root = exports ? this 

# root.PHI_RATIO = 1.6180339887498948482    

root.collections_viz = (json_path) ->
  d3.json json_path, (data) ->
    viz_data = node_trees_to_d3 data
    width = 1000
    height = 700
    format = d3.format(",d")

    pack = d3.layout.pack()
      .size([ width - 4, height - 4 ])
      .value((d) -> d.size)

    vis = d3.select("#viz-collections").append("svg")
        .attr("width", width)
        .attr("height", height)
        .attr("class", "pack")
      .append("g")
        .attr("transform", "translate(2, 2)")

    node = vis.data([ data ]).selectAll("#viz-collections g.node")
        .data(pack.nodes)
      .enter().append("g")
        .attr("class", (d) -> if d.children then "node" else "leaf node")
        .attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")

    node.append("title")
      .text (d) -> d.name + (if d.children then "" else ": " + format(d.size))

    node.append("circle")
      .attr("r", (d) -> d.r)
      .on "click", (d) -> if d.children then (window.location = d.url) else undefined

    node.filter((d) -> d.children)
      .append("text")
        .attr("text-anchor", "middle")
        .attr("dy", ".3em")
        .text (d) -> if d.name.length <= d.r/3 then d.name else ""
        
root.node_trees_to_d3 = (node_trees, root_node) ->
  if root_node?
  else # if node_trees[""] and node_trees[""][""] 
    "name": Object.keys(node_trees[""][""])[0]
    "children": 
      for own type, properties of node_trees[""] when type
        "name": type
        "children": 
          for own property_name, weight of properties
            "name": property_name
            "size": weight
