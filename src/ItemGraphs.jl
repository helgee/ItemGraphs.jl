module ItemGraphs

import LightGraphs: AbstractGraph, DiGraph, add_edge!, add_vertex!, nv,
    dijkstra_shortest_paths, enumerate_paths, has_vertex, has_path

export ItemGraph, add_vertex!, add_edge!, getpath, has_vertex, has_path,
    ItemGraphException

struct ItemGraphException <: Exception
    msg::String
end
Base.show(io::IO, ex::ItemGraphException) = print(io, ex.msg)

struct ItemGraph{T,G}
    graph::G
    ids::Dict{Int,T}
    items::Dict{T,Int}
    paths::Dict{T,Dict{T,Vector{T}}}
    lazy::Bool
    ItemGraph{T}(graph::G; lazy = false) where {T,G <: AbstractGraph} = new{T,G}(graph,
        Dict{Int,T}(),
        Dict{T,Int}(),
        Dict{T,Dict{T,Vector{T}}}(),
        lazy,)
end

ItemGraph{T}(; kwargs...) where {T} = ItemGraph{T}(DiGraph(); kwargs...)

getid(graph::ItemGraph{T}, item::T) where {T} = graph.items[item]
getitem(graph::ItemGraph, id) = graph.ids[id]
has_vertex(graph::ItemGraph, item) = haskey(graph.items, item)
has_path(graph::ItemGraph, from, to) = has_path(graph.graph, getid(graph, from), getid(graph, to))

function add_vertex!(graph::ItemGraph{T}, item::T) where T
    has_vertex(graph, item) && return

    add_vertex!(graph.graph)
    id = nv(graph.graph)
    push!(graph.ids, id => item)
    push!(graph.items, item => id)
    nothing
end

function add_edge!(graph::ItemGraph{T}, from::T, to::T) where T
    add_vertex!(graph, from)
    add_vertex!(graph, to)
    add_edge!(graph.graph, getid(graph, from), getid(graph, to))

    !graph.lazy && calculate_paths!(graph)
    nothing
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

function getpath(graph, from, to)
    for vertex in (from, to)
        !has_vertex(graph, vertex) && throw(ItemGraphException("There is no vertex '$vertex'."))
    end

    !has_path(graph, from, to) && throw(ItemGraphException("There is no path between '$from' and '$to'."))

    graph.lazy && return calculate_path(graph, from, to)

    graph.paths[from][to]
end

end # module
