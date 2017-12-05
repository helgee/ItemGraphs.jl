module ItemGraphs

import LightGraphs: AbstractGraph, DiGraph, add_edge!, add_vertex!, nv,
    dijkstra_shortest_paths, enumerate_paths

export ItemGraph, add_vertex!, add_edge!

struct ItemGraph{T,G}
    graph::G
    ids::Dict{Int,T}
    items::Dict{T,Int}
    paths::Dict{T,Dict{T,Vector{T}}}
    recalculate::Bool
    ItemGraph{T}(graph::G; recalculate=true) where {T,G<:AbstractGraph} = new{T,G}(
        graph,
        Dict{Int,T}(),
        Dict{T,Int}(),
        Dict{T,Dict{T,Vector{T}}}(),
        recalculate,
    )
end

ItemGraph{T}(; kwargs...) where {T} = ItemGraph{T}(DiGraph(); kwargs...)

getid(graph::ItemGraph{T}, item::T) where {T} = graph.items[item]
getitem(graph::ItemGraph, id) = graph.ids[id]

function add_vertex!(graph::ItemGraph{T}, item::T) where T  
    if !haskey(graph.items, item)
        add_vertex!(graph.graph)
        id = nv(graph.graph)
        merge!(graph.ids, Dict(id=>item))
        merge!(graph.items, Dict(item=>id))
    end
end

function add_edge!(graph::ItemGraph{T}, from::T, to::T) where T
    add_vertex!(graph, from)
    add_vertex!(graph, to)
    add_edge!(graph.graph, getid(graph, from), getid(graph, to))

    graph.recalculate && all_paths!(graph)
end

function all_paths!(graph::ItemGraph)
    for (origin, oid) in graph.items
        d = dijkstra_shortest_paths(graph.graph, oid)
        for (target, tid) in graph.items
            origin == target && continue
            path = getitem.(graph, enumerate_paths(d, tid))
            if haskey(graph.paths, origin)
                merge!(graph.paths[origin], Dict(target=>path))
            else
                merge!(graph.paths, Dict(origin=>Dict(target=>path)))
            end
        end
    end
end

getitems(graph, ids) = map(x->getitem(graph, x), ids)

function getpath(graph::ItemGraph{T}, from::T, to::T) where T
    map(x->getitem(graph, x), enumerate_paths(
        dijkstra_shortest_paths(graph.graph, getid(graph, from)), getid(graph, to)))
end

end # module
