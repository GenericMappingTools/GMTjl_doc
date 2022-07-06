# This file was generated, do not modify it. # hide
using GMT, PrettyTables   # hide
getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
io = IOBuffer() # hide
D = gmtread(getpath4docs("mff_bb.txt"))
pretty_table(io, D.data; header=D.colnames, backend=Val(:html))	# hide
println("~~~" * String(take!(io)) * "~~~") # hide