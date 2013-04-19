#!/usr/bin/env coffee

# Usage:
# bin/csv2json.coffee source.csv target.json 
# or if you prefer:
# node bin/csv2json.js source.csv target.json 

_ = require 'underscore'
csv = require 'csv'
                     
[source, target] = process.argv[2..]  # all relevant command line args 
               
name = _.last(target.split '/').replace(/\.\w+$/, '')  # remove directories and file extension
nodes = {}   # a hash of hashes of arrays of strings
csv_data = csv().from.path(source)
  
csv_data.to.array((rows) -> 
  headers = rows.shift()
  property_headers = headers[..]  # copy of headers
  property_headers.shift()        # drop first column (the "content"), other columns are "properties"

  for row, row_index in rows  
    for node, column_index in row
      if node
        property_name = headers[column_index]
        nodes[node] ?= {}
        nodes[node]["is"] ?= []
        nodes[node]["is"].push property_name
        nodes[node]["is"] = _.uniq(nodes[node]["is"])

        nodes[property_name] ?= {}
        nodes[property_name]["nodes"] ?= []
        nodes[property_name]["nodes"].push node
        nodes[property_name]["nodes"] = _.uniq(nodes[property_name]["nodes"])
        
    row_node = row.shift()  # first column is the "content"
    for property, column_index in row
      if property       
        property_name = property_headers[column_index]
        nodes[row_node] ?= {}    
        nodes[row_node][property_name] ?= []
        nodes[row_node][property_name].push property
        nodes[row_node][property_name] = _.uniq(nodes[row_node][property_name])
    log_if(row_index == rows.length-1)
)

log_if = (really)->
  if really
    json = JSON.stringify nodes, null, 4
    console.log json
