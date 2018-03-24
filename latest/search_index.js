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
    "category": "type",
    "text": "ItemGraph{T,S}([graph]; lazy=false)\n\nCreate a new ItemGraph with items of type T based on a graph from LightGraphs. Items of type S can be assigned to the edges of the graph, this type can be omitted and will be Float64 by default. graph can be omitted as well and a DiGraph will be used by default. If lazy is set to true, the paths between items will be computed on-demand when items is called. Otherwise all paths are recomputed whenever a new edge is inserted.\n\n\n\n\n\n"
},

{
    "location": "api.html#ItemGraphs.edgeitem-Union{Tuple{T}, Tuple{ItemGraph{T,S,G} where G where S,T,T}} where T",
    "page": "API",
    "title": "ItemGraphs.edgeitem",
    "category": "method",
    "text": "edgeitem(graph, from, to)\n\nGet the item assigned to the edge between from and to.\n\n\n\n\n\n"
},

{
    "location": "api.html#ItemGraphs.edgeitems-Union{Tuple{S}, Tuple{T}, Tuple{ItemGraph{T,S,G} where G,T,T}} where S where T",
    "page": "API",
    "title": "ItemGraphs.edgeitems",
    "category": "method",
    "text": "edgeitems(graph, from, to)\n\nGet all items assigned to the edges between from and to.\n\n\n\n\n\n"
},

{
    "location": "api.html#ItemGraphs.items-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "ItemGraphs.items",
    "category": "method",
    "text": "items(graph, from, to)\n\nGet the items on the path between and including from and to. Will throw an ItemGraphsException if either from or to are not a part of graph or if there is no path between them.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.SimpleGraphs.add_edge!-Union{Tuple{S}, Tuple{T}, Tuple{ItemGraph{T,S,G} where G,T,T}, Tuple{ItemGraph{T,S,G} where G,T,T,S}} where S where T",
    "page": "API",
    "title": "LightGraphs.SimpleGraphs.add_edge!",
    "category": "method",
    "text": "add_edge!(graph, from, to, [item])\n\nAdd an edge between from and to to graph. Optionally assign an item to the edge.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.SimpleGraphs.add_vertex!-Union{Tuple{T}, Tuple{ItemGraph{T,S,G} where G where S,T}} where T",
    "page": "API",
    "title": "LightGraphs.SimpleGraphs.add_vertex!",
    "category": "method",
    "text": "add_vertex!(graph, item)\n\nAdd item to graph.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.has_path-Tuple{ItemGraph,Any,Any}",
    "page": "API",
    "title": "LightGraphs.has_path",
    "category": "method",
    "text": "has_path(graph, from, to)\n\nReturn true if there is a path between from and to in graph.\n\n\n\n\n\n"
},

{
    "location": "api.html#LightGraphs.has_vertex-Tuple{ItemGraph,Any}",
    "page": "API",
    "title": "LightGraphs.has_vertex",
    "category": "method",
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
