class Nodenav extends Batman.App
  @set 'mission', 'fight crime'

  # Set the root route to ExamplesController#index.
  @root 'examples#index'
  # @root 'node_trees#show'

# Make Nodenav available in the global namespace so it can be used
# as a namespace and bound to in views.
window.Nodenav = Nodenav
