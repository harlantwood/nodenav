'use strict'

class Nodenav.Gittree extends Batman.Model
  @encode 'location'
  @persist Batman.LocalStorage
  @validate 'location', presence: true
  @storageKey: 'nodenav-gittree'
                     
  loadRepo: (options = {}) ->
    opts = $.extend({sha: 'HEAD', recursive: 1}, options, {location: @location()})
    opts.recursive = if opts.recursive then 1 else 0
    url = "https://api.github.com/repos/#{opts.location}/git/trees/#{opts.sha}?recursive=#{opts.recursive}"
    $.ajax($.extend {
      url: url
      dataType: 'jsonp'
    }, opts)

  location: ->
    @repo()

  repo: ->
    m[1] if m = @get('location').match(///github\.com/([^/]+/[^/]+)///)

  parse: (data) ->
    paths =
      root:
        name: ''
        path: ''
        children: []     
        
    for node in data.tree
      if node.type == 'blob'
        @parseBlob(paths, node)
      else
        @parseTree(paths, node)
    @collapse(paths)

  parseBlob: (paths, node) ->
    segments = "root/#{node.path}".match(/(.*)\/(.*)/)
    node.name = segments[2]
    path = segments[1]
    name = path.substr(5)
    paths[path] ||=
      name: name
      path: node.path
      children: []
    paths[path].children.push(node)

  parseTree: (paths, node) ->
    path = "root/#{node.path}"
    name = path.match(/(.*)\/(.*)/)[2]
    paths[path] ||=
      name: name
      children: []
    $.extend(paths[path], node)

  collapse: (paths) ->
    for path, node of paths
      parent = path.match(/(.*)\//)
      continue unless parent && parent = parent[1]
      paths[parent].children.push(node)
    paths
