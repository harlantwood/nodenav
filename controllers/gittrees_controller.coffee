class Nodenav.GittreesController extends Batman.Controller
  routingKey: 'gittrees'
  EXAMPLE_REPO_URL = "https://github.com/wycats/thor"

  RENDERERS =
    circlepack: require 'lib/canopy/d3/circlepack'
    radialtree: require 'lib/canopy/d3/radialtree'

  constructor: ->
    super
    # @delegate 'click', '[data-path="root"]', @reset
    # @delegate 'click', '[data-viztype]', @switch
    # @delegate 'change', 'input.repo-url', @loadGitRepo

  new: -> 
    @set 'newGittree', new Nodenav.Gittree(repourl: EXAMPLE_REPO_URL)
    console.log 111000    

  # loadGitRepo: =>
  #   url = @$('input.repo-url').val()
  #   repo = github.getRepoFromURL url
  #   github.loadRepo repo, success: (results) =>
  #     @data = github.parse results.data
  #     @renderViz @data.root 

  createGittree: ->
    console.log 111
    @get('newGittree').save (err, gittree) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @loadGitRepo(gittree)
        console.log 222                     

  loadGitRepo: (gittree) ->
    # repo = gittree.getRepoFromURL url
    gittree.loadRepo success: (results) =>
      @data = gittree.parse results.data
      @renderViz @data.root 
      console.log 444
  
  renderViz: (data, type) ->
    # if type
    #   @$('[data-viztype]').removeClass('active')
    #   @$("[data-viztype=#{type}]").addClass('active')
  
    # todo: move to own view
    # @$(@path_elem).find('span').text(data.path)
  
    rendererName = 'circle-packing'  # $('[data-viztype].active').data('viztype')
  
    $viz = @$('#viz-graph')
      .empty()
      .removeClass()
      .addClass rendererName
  
    @renderer = new RENDERERS[rendererName]
    @renderer.render '#viz-graph', data,
      width   : $viz.width()
      height  : $viz.height()
      # click   : @zoom
    # @renderList data if data.children
