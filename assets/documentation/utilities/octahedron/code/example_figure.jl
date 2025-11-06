# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

FV = octahedron();
viz(FV)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_15068399540688586166.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide