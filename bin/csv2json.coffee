#!/usr/bin/env coffee

# Usage:
# bin/csv2json.coffee source.csv target.json 
# or if you prefer:
# node bin/csv2json.js source.csv target.json 

_ = require 'underscore'
csv = require 'csv'

BASE_WEIGHT = 0.5
                     
[source, target] = process.argv[2..]  # all relevant command line args 
               
name = _.last(target.split '/').replace(/\.\w+$/, '')  # remove directories and file extension
nodes = {}   # a hash of hashes of hashes of numbers, 0..1, for more details see <https://gist.github.com/harlantwood/4a698db1cd6e7fe00bd9>
csv_data = csv().from.path(source)
  
csv_data.to.array((rows) -> 
  headers = rows.shift()
  property_headers = headers[..]  # copy of headers
  property_headers.shift()        # drop first column (the "content"), other columns are "properties"

  for row, row_index in rows  
    for node, column_index in row
      if node
        property_name = headers[column_index]    
        insert node,          "type",  property_name
        insert property_name, "nodes", node
    row_content = row.shift()  # first column is the "content"
    
    for property, column_index in row
      if property       
        property_name = property_headers[column_index]
        insert row_content, property_name, property

    log_if(row_index == rows.length-1)
)

insert = (key1, key2, key3) ->
  nodes[key1] ?= {}
  nodes[key1][key2] ?= {}          
  nodes[key1][key2][key3] = BASE_WEIGHT


log_if = (really)->
  if really
    json = JSON.stringify nodes, null, 4
    console.log json
