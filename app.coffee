root = exports ? this 

# root.PHI_RATIO = 1.6180339887498948482    

root.collections_viz = (json_path) ->
  d3.json json_path, (node_trees) ->             
    d3_node_trees = node_trees_to_d3_trees(node_trees)
    root.render_viz d3_node_trees, ""

root.render_viz = (d3_node_trees, key) ->     

  d3_node_tree = d3_node_trees[key]
  
  $('#viz-graph').empty()

  width = 1000
  height = 700
  format = d3.format(",d")

  pack = d3.layout.pack()
    .size([ width - 4, height - 4 ])
    .value((d) -> d.size)

  vis = d3.select("#viz-graph").append("svg")
      .attr("width", width)
      .attr("height", height)
      .attr("class", "pack")
    .append("g")
      .attr("transform", "translate(2, 2)")

  node = vis.data([ d3_node_tree ]).selectAll("#viz-graph g.node")
      .data(pack.nodes)
    .enter().append("g")
      .attr("class", (d) -> if d.children then "node" else "leaf node")
      .attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")

  node.append("title")
    .text (d) -> d.name + (if d.children then "" else ": " + format(d.size))

  node.append("circle")
    .attr("r", (d) -> d.r) 
    .filter((d) -> !d.children)
      .on "click", (d) -> (root.render_viz(d3_node_trees, d.name))

  node.filter((d) -> !d.children)
    .append("text")
      .attr("text-anchor", "middle")
      .attr("dy", ".3em")
      .text (d) -> if d.name.length <= d.r/3 then d.name else ""

root.node_trees_to_d3_trees = (node_trees) ->       
  viz_data = {}
  for own tree_name, tree_data of node_trees
    node_tree = new NodeTree(tree_name, tree_data)
    viz_data[tree_name] = node_tree.to_d3()
  viz_data
        