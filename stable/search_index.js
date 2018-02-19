var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#ItemGraphs-1",
    "page": "Home",
    "title": "ItemGraphs",
    "category": "section",
    "text": "Shortest paths between itemsItemGraphs is a simple wrapper around LightGraphs that enables my most common use case for graph-like data structures: I have a collection of items that are in relations between each other and I want to get the shortest path between two items. That\'s it!"
},

{
    "location": "index.html#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "The package can be installed through Julia\'s package manager:Pkg.add(\"ItemGraphs\")"
},

{
    "location": "index.html#Quickstart-1",
    "page": "Home",
    "title": "Quickstart",
    "category": "section",
    "text": "# Create an ItemGraph that has integers as vertices\ng = ItemGraph{Int}()\n\n# Add some vertices\nadd_vertex!(g, 101)\nadd_vertex!(g, 202)\n\n# Add some edges. If the vertices do not exists, they will be added as well\nadd_edge!(g, 101, 202)\nadd_edge!(g, 202, 303)\nadd_edge!(g, 202, 404)\n\n# Get the shortest path, returns [101, 202, 404]\ngetpath(g, 101, 404)"
},

{
    "location": "api.html#",
    "page": "API",
    "title": "API",
    "category": "page",
    "text": ""
},

{
    "location": "api.html#ItemGraphs.ItemGraph",
    "page": "API",
    "title": "ItemGraphs.ItemGraph",
    "category": "Type",
    "text": "ItemGraph{T}([graph]; lazy=false)\n\nCreate a new ItemGraph with items of type T based on a graph from LightGraphs. graph can be omitted and a DiGraph will be used by default. If lazy is set to true, the paths between items will be computed on-demand when getpath is called. Otherwise all paths recomputed whenever a new edge is inserted.\n\n\n\n\n\n"
},

{
    "location": "api.html#ItemGraphs.getpath-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "ItemGraphs.getpath",
    "category": "Method",
    "text": "getpath(graph, from, to)\n\nGet the path between the items from and to. Will throw an ItemGraphsException if either from or to are not a part of graph or if there is no path between them.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.add_edge!-Union{Tuple{T}, Tuple{ItemGraph{T,G} where G,T,T}} where T",
    "page": "API",
    "title": "LightGraphs.add_edge!",
    "category": "Method",
    "text": "add_edge!(graph, from, to)\n\nAdd an edge between from and to to graph.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.add_vertex!-Union{Tuple{T}, Tuple{ItemGraph{T,G} where G,T}} where T",
    "page": "API",
    "title": "LightGraphs.add_vertex!",
    "category": "Method",
    "text": "add_vertex!(graph, item)\n\nAdd item to graph.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.has_path-Tuple{ItemGraph,Any,Any}",
    "page": "API",
    "title": "LightGraphs.has_path",
    "category": "Method",
    "text": "has_path(graph, from, to)\n\nReturn true if there is a path between from and to in graph.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.has_vertex-Tuple{ItemGraph,Any}",
    "page": "API",
    "title": "LightGraphs.has_vertex",
    "category": "Method",
    "text": "has_vertex(graph, item)\n\nReturn true if item is contained in graph.\n\n\n\n\n\n"
},

{
    "location": "api.html#API-1",
    "page": "API",
    "title": "API",
    "category": "section",
    "text": "Modules = [ItemGraphs]\nPrivate = false"
},

]}
