# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

makecpt(cmap=:turbo, range=(0,80,10))
ternary("@ternary.txt", region=(0,100,0,100,0,100), marker=:circ, ms=0.1, vertex_labels="Water/Air/Limestone",
    frame=(annot=:auto, grid=:a, ticks=:a, alabel="Water component", blabel="Air component", clabel="Limestone component", suffix=" %", fill=:ivory, title="Example data from MATLAB Central"), show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_10491602679937465156.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide