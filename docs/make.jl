using Documenter, ItemGraphs

makedocs(
    format = :html,
    sitename = "ItemGraphs.jl",
    authors = "Helge Eichhorn",
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
    ],
)

deploydocs(
    repo = "github.com/helgee/ItemGraphs.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)