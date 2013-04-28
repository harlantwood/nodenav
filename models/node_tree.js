// Generated by CoffeeScript 1.6.2
(function() {
  var root,
    __hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.NodeTree = (function() {
    var NOT_A_COLOR;

    NOT_A_COLOR = ['Invalid Color Name', 'Invalid Color Name', 'Invalid Color Name'];

    function NodeTree(name, properties) {
      this.name = name;
      this.properties = properties;
      if (typeof this.name !== "string") {
        throw "ArgumentException";
      }
      if (!(this.properties instanceof Object)) {
        throw "ArgumentException";
      }
      this.color = [0, 0, 0];
    }

    NodeTree.prototype.to_d3 = function() {
      var property_name, weight;

      return {
        "name": this.name,
        "children": (function() {
          var _ref, _results;

          _ref = this.properties;
          _results = [];
          for (property_name in _ref) {
            if (!__hasProp.call(_ref, property_name)) continue;
            weight = _ref[property_name];
            if (property_name) {
              _results.push({
                "name": property_name,
                "size": weight
              });
            }
          }
          return _results;
        }).call(this)
      };
    };

    NodeTree.prototype.hex_color = function() {
      var b, g, property_name, r, rgb_color, valid_color, weight, _ref, _ref1;

      _ref = this.properties;
      for (property_name in _ref) {
        if (!__hasProp.call(_ref, property_name)) continue;
        weight = _ref[property_name];
        if (!(property_name)) {
          continue;
        }
        rgb_color = Colors.name2rgb(property_name);
        valid_color = !_.isEqual(rgb_color.a, NOT_A_COLOR);
        if (valid_color) {
          _ref1 = rgb_color.a, r = _ref1[0], g = _ref1[1], b = _ref1[2];
          this.color[0] += r / 255;
          this.color[1] += g / 255;
          this.color[2] += b / 255;
        }
      }
      this.normalize_color();
      return Colors.rgb2hex.apply(Colors, this.color_rgb_255());
    };

    NodeTree.prototype.normalize_color = function() {
      var component, max_component;

      max_component = _.max(this.color);
      if (max_component > 1) {
        return this.color = (function() {
          var _i, _len, _ref, _results;

          _ref = this.color;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            component = _ref[_i];
            _results.push(component / max_component);
          }
          return _results;
        }).call(this);
      }
    };

    NodeTree.prototype.color_rgb_255 = function() {
      var component, _i, _len, _ref, _results;

      _ref = this.color;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        component = _ref[_i];
        _results.push(Math.round(component * 255));
      }
      return _results;
    };

    return NodeTree;

  })();

}).call(this);
