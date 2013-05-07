class Nodenav.GittreesController extends Batman.Controller
  routingKey: 'gittrees'
  EXAMPLE_REPO_URL = "https://github.com/wycats/thor"

  new: -> 
    @set 'newGittree', new Nodenav.Gittree(repourl: EXAMPLE_REPO_URL)

  createGittree: ->
    @get('newGittree').save (err, gittree) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @loadGitRepo(gittree)

  loadGitRepo: (gittree) ->
    # repo = gittree.getRepoFromURL url
    gittree.loadRepo success: (results) =>
      @data = gittree.parse results.data
      @renderViz @data.root 
  
  renderViz: (data, type) ->
    $viz = $('#viz-graph').empty()
  
    @renderer = new Nodenav.D3.Circlepack()
    @renderer.render '#viz-graph', data,
      width   : $viz.width()
      height  : $viz.height()
      # click   : @zoom
    # @renderList data if data.children
