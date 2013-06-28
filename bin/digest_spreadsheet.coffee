#!/usr/bin/env coffee

# Usage:
# bin/digest_spreadsheet.coffee source.csv

'use strict'

_ = require 'underscore'
fs = require 'fs'
path = require 'path'
csv = require 'csv'

BASE_WEIGHT = 1

source = process.argv[2]
source = fs.realpathSync source
name = _.last(source.split '/').replace(/\.\w+$/, '')  # remove directories and file extension

base_name = source.replace /.csv$/, ''
target_file_store_dir = base_name
target_json = "#{base_name}.json"
                        
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

  fs.writeFileSync target_json, JSON.stringify(nodes, null, 4)
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
  write_tree target_file_store_dir, key1
  write_tree target_file_store_dir, key1, key2

write_tree = (path_segments...) ->
  dir = path.join path_segments...
  try fs.mkdirSync dir
  fs.writeFileSync path.join(dir, '-'), '-'

