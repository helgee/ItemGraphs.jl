module ItemGraphs

import LightGraphs: AbstractGraph, DiGraph, add_edge!, add_vertex!, nv,
    dijkstra_shortest_paths, enumerate_paths, has_vertex, has_path

export ItemGraph, add_vertex!, add_edge!, getpath, has_vertex, has_path,
    ItemGraphException

struct ItemGraphException <: Exception
    msg::String
end
Base.show(io::IO, ex::ItemGraphException) = print(io, ex.msg)

"""
    ItemGraph{T}([graph]; lazy=false)

Create a new ItemGraph with items of type `T` based on a `graph` from `LightGraphs`.
`graph` can be omitted and a `DiGraph` will be used by default.
If `lazy` is set to true, the paths between items will be computed on-demand when
[`getpath`](@ref) is called.
Otherwise all paths recomputed whenever a new edge is inserted.
"""
struct ItemGraph{T,S,G}
    graph::G
    ids::Dict{Int,T}
    items::Dict{T,Int}
    edges::Dict{Int,Dict{Int,S}}
    paths::Dict{T,Dict{T,Vector{T}}}
    lazy::Bool
    ItemGraph{T,S}(graph::G; lazy = false) where {T, S, G <: AbstractGraph} = new{T,S,G}(graph,
        Dict{Int,T}(),
        Dict{T,Int}(),
        Dict{Int,Dict{Int,S}}(),
        Dict{T,Dict{T,Vector{T}}}(),
        lazy,)
end

ItemGraph{T}(; kwargs...) where {T} = ItemGraph{T,Float64}(DiGraph(); kwargs...)

getid(graph::ItemGraph{T}, item::T) where {T} = graph.items[item]
getitem(graph::ItemGraph, id) = graph.ids[id]
"""
    has_vertex(graph, item)

Return true if `item` is contained in `graph`.
"""
has_vertex(graph::ItemGraph, item) = haskey(graph.items, item)
"""
    has_path(graph, from, to)

Return true if there is a path between `from` and `to` in `graph`.
"""
has_path(graph::ItemGraph, from, to) = has_path(graph.graph, getid(graph, from), getid(graph, to))

"""
    add_vertex!(graph, item)

Add `item` to `graph`.
"""
function add_vertex!(graph::ItemGraph{T}, item::T) where T
    has_vertex(graph, item) && return

    add_vertex!(graph.graph)
    id = nv(graph.graph)
    push!(graph.ids, id => item)
    push!(graph.items, item => id)
    nothing
end

"""
    add_edge!(graph, from, to)

Add an edge between `from` and `to` to `graph`.
"""
function add_edge!(graph::ItemGraph{T}, from::T, to::T) where T
    add_vertex!(graph, from)
    add_vertex!(graph, to)
    add_edge!(graph.graph, getid(graph, from), getid(graph, to))

    !graph.lazy && calculate_paths!(graph)
    nothing
end

"""
    getpath(graph, from, to)

Get the path between the items `from` and `to`.
Will throw an `ItemGraphsException` if either `from` or `to` are not a part of `graph` or if there
is no path between them.
"""
function getpath(graph, from, to)
    for vertex in (from, to)
        !has_vertex(graph, vertex) && throw(ItemGraphException("There is no vertex '$vertex'."))
    end

    !has_path(graph, from, to) && throw(ItemGraphException("There is no path between '$from' and '$to'."))

    graph.lazy && return calculate_path(graph, from, to)

    graph.paths[from][to]
end

function calculate_paths!(graph::ItemGraph{T}) where T
    for (origin, oid) in graph.items
        d = dijkstra_shortest_paths(graph.graph, oid)
        for (target, tid) in graph.items
            origin == target && continue
            path = getitem.(graph, enumerate_paths(d, tid))
            paths = get!(graph.paths, origin, Dict{T,Vector{T}}())
            push!(paths, target => path)
        end
    end
end

function calculate_path(graph::ItemGraph{T}, from, to) where T
    origin = getid(graph, from)
    target = getid(graph, to)

    getitem.(graph, enumerate_paths(dijkstra_shortest_paths(graph.graph, origin), target))::Vector{T}
end

end # module
