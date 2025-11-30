# This file was generated, do not modify it. # hide
using GMT, PrettyTables   # hide
getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
io = IOBuffer() # hide
D = earthtide(range=("2022-07-07T", "2022-07-08T", "1m"), location=(-82,9))
PrettyTables.pretty_table(io, D.data[1:5,:]; header=D.colnames, backend=Val(:html))	# hide
println("~~~" * String(take!(io)) * "~~~") # hide