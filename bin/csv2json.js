// Generated by CoffeeScript 1.6.2
(function() {
  var csv, csv_data, log_if, name, nodes, source, target, _, _ref;

  _ = require('underscore');

  csv = require('csv');

  _ref = process.argv.slice(2), source = _ref[0], target = _ref[1];

  name = _.last(target.split('/')).replace(/\.\w+$/, '');

  nodes = {};

  csv_data = csv().from.path(source);

  csv_data.to.array(function(rows) {
    var column_index, headers, node, property, property_headers, property_name, row, row_index, row_node, _base, _base1, _base2, _i, _j, _k, _len, _len1, _len2, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _results;

    headers = rows.shift();
    property_headers = headers.slice(0);
    property_headers.shift();
    _results = [];
    for (row_index = _i = 0, _len = rows.length; _i < _len; row_index = ++_i) {
      row = rows[row_index];
      for (column_index = _j = 0, _len1 = row.length; _j < _len1; column_index = ++_j) {
        node = row[column_index];
        if (node) {
          property_name = headers[column_index];
          if ((_ref1 = nodes[node]) == null) {
            nodes[node] = {};
          }
          if ((_ref2 = (_base = nodes[node])["is"]) == null) {
            _base["is"] = [];
          }
          nodes[node]["is"].push(property_name);
          nodes[node]["is"] = _.uniq(nodes[node]["is"]);
          if ((_ref3 = nodes[property_name]) == null) {
            nodes[property_name] = {};
          }
          if ((_ref4 = (_base1 = nodes[property_name])["nodes"]) == null) {
            _base1["nodes"] = [];
          }
          nodes[property_name]["nodes"].push(node);
          nodes[property_name]["nodes"] = _.uniq(nodes[property_name]["nodes"]);
        }
      }
      row_node = row.shift();
      for (column_index = _k = 0, _len2 = row.length; _k < _len2; column_index = ++_k) {
        property = row[column_index];
        if (property) {
          property_name = property_headers[column_index];
          if ((_ref5 = nodes[row_node]) == null) {
            nodes[row_node] = {};
          }
          if ((_ref6 = (_base2 = nodes[row_node])[property_name]) == null) {
            _base2[property_name] = [];
          }
          nodes[row_node][property_name].push(property);
          nodes[row_node][property_name] = _.uniq(nodes[row_node][property_name]);
        }
      }
      _results.push(log_if(row_index === rows.length - 1));
    }
    return _results;
  });

  log_if = function(really) {
    var json;

    if (really) {
      json = JSON.stringify(nodes, null, 4);
      return console.log(json);
    }
  };

}).call(this);
