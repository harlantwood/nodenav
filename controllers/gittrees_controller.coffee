"use strict"

class Nodenav.GittreesController extends Batman.Controller
  routingKey: 'gittrees'
  EXAMPLE_REPO_URL = "https://github.com/harlantwood/nodenav"
  RENDERERS = 
    circlepack: Nodenav.D3.Circlepack
    radialtree: Nodenav.D3.RadialTree

  new: -> 
    @set 'newGittree', new Nodenav.Gittree(repourl: EXAMPLE_REPO_URL)

  createGittree: ->
    @get('newGittree').save (err, gittree) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @loadGitRepo(gittree)
        @set 'newGittree', new Nodenav.Gittree(repourl: gittree.get('repourl'))

  loadGitRepo: (gittree) ->
    gittree.loadRepo success: (results) =>
      @data = gittree.parse results.data
      @renderViz @data.root 
  
  renderViz: (data, viz_type) ->
    viz_type or= $('#tabs > ul > li:first-child').data('viztype')

    $viz = $('#viz-graph')
      .empty()
      .removeAttr('class')
      .addClass(viz_type)

    @renderer = new RENDERERS[viz_type]
    @renderer.render '#viz-graph', data,
      width   : $viz.width()
      height  : $viz.height() 
      diameter: 960
      click   : @zoom
    # @renderList data if data.children

  switch: (link) ->  
    $link = $(link)
    # $link.preventDefault()
    viz_type = $link.parent().attr('data-viztype')
    @renderViz @data.root, viz_type
  
  zoom: (node) =>
    @renderViz node
  
  reset: ->
    @renderViz @data.root

  # renderList: (data) ->
  #   $list = @$('viz-list').empty()
  #   data = data.children.sort (a, b) ->
  #     a = a.name.toLowerCase(); b = b.name.toLowerCase()
  #     return 0 if (a == b)
  #     return 1 if (a > b)
  #     return -1 if (a < b)
  #   items = for node in data
  #     "<div>#{node.path}</div>"
  #   $list.append items
  
