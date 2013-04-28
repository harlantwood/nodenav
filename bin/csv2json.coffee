#!/usr/bin/env coffee

# Usage:
# bin/csv2json.coffee source.csv target.json 
# or if you prefer:
# node bin/csv2json.js source.csv target.json 

_ = require 'underscore'
csv = require 'csv'

BASE_WEIGHT = 1
                     
[source, target] = process.argv[2..]  # all relevant command line args 
               
name = _.last(target.split '/').replace(/\.\w+$/, '')  # remove directories and file extension
nodes = {}   # a hash of hashes of hashes of numbers, 0..1, for more details see <https://gist.github.com/harlantwood/4a698db1cd6e7fe00bd9>
csv_data = csv().from.path(source)
  
csv_data.to.array((rows) -> 
  rows = ((node.trim() for node in row) for row in rows)
  headers = rows.shift()
  property_headers = headers[..]  # copy of headers
  property_headers.shift()        # drop first column (the "content"), other columns are "properties"

  insert "name", name
  
  for row, row_index in rows  
    insert "", row[0] if row[0]
    for node, column_index in row
      if node
        property_name = headers[column_index]
        insert property_name, node
        if (parent_node = find_parent(headers, row, column_index))
          insert parent_node, node

  json = JSON.stringify nodes, null, 4
  console.log json
)

find_parent = (headers, row, column_index) ->
  i = column_index
  i-- while headers[i] == headers[i - 1] and i >= 0
  parent = i - 1
  row[parent]

insert = (key1, key2) ->
  nodes[key1] ?= {}
  nodes[key1][key2] ?= 0
  nodes[key1][key2] += 1
