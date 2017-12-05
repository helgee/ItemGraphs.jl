using ItemGraphs
using Base.Test

abstract type Item end

struct A <: Item end
struct B <: Item end
struct C <: Item end
struct D <: Item end

@testset "ItemGraphs" begin
    g = ItemGraph{Item}()
    add_edge!(g, A(), B())
    add_edge!(g, B(), C())
    add_edge!(g, B(), D())

    @test ItemGraphs.getid(g, A()) == 1
    @test ItemGraphs.getid(g, B()) == 2
    @test ItemGraphs.getid(g, C()) == 3
    @test ItemGraphs.getid(g, D()) == 4
    @test ItemGraphs.getitem(g, 1) == A()
    @test ItemGraphs.getitem(g, 2) == B()
    @test ItemGraphs.getitem(g, 3) == C()
    @test ItemGraphs.getitem(g, 4) == D()

    g = ItemGraph{Int}()
    add_edge!(g, 101, 202)
    add_edge!(g, 202, 303)
    add_edge!(g, 202, 404)

    @test ItemGraphs.getid(g, 101) == 1
    @test ItemGraphs.getid(g, 202) == 2
    @test ItemGraphs.getid(g, 303) == 3
    @test ItemGraphs.getid(g, 404) == 4
    @test ItemGraphs.getitem(g, 1) == 101
    @test ItemGraphs.getitem(g, 2) == 202
    @test ItemGraphs.getitem(g, 3) == 303
    @test ItemGraphs.getitem(g, 4) == 404
end