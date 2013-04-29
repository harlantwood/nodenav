root = exports ? this

# Basic D3 Reingold-Tilford radial tree

root.collections_viz = (json_path) ->
  d3.json json_path, (data) ->
    diameter = 960
    tree = d3.layout.tree()
      .size([360, diameter / 2 - 120])
      .separation((a, b) -> ((if a.parent is b.parent then 1 else 2)) / a.depth)

    diagonal = d3.svg.diagonal.radial()
      .projection((d) -> [d.y, d.x / 180 * Math.PI])

    svg = d3.select("body").append("svg")
        .attr("width", diameter)
        .attr("height", diameter - 150)
      .append("g")
        .attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")")

    d3.json json_path, (error, root) ->
      nodes = tree.nodes(root)
      links = tree.links(nodes)
      link = svg.selectAll(".link")
          .data(links)
        .enter()
          .append("path")
          .attr("class", "link")
          .attr("d", diagonal)
          
      node = svg.selectAll(".node")
          .data(nodes)
        .enter()
          .append("g")
          .attr("class", "node")
          .attr("transform", (d) -> "rotate(" + (d.x - 90) + ")translate(" + d.y + ")")
          
      node.append("circle")
          .attr "r", 4.5
          
      node.append("text")
          .attr("dy", ".31em")
          .attr("text-anchor", (d) -> (if d.x < 180 then "start" else "end"))
          .attr("transform", (d) -> (if d.x < 180 then "translate(8)" else "rotate(180)translate(-8)"))
          .text (d) -> d.name

    d3.select(self.frameElement).style "height", diameter - 150 + "px"
