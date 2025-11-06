# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
marginalhist(randn(2500,2), cmap=:lisbon, density=true, histkw=(fill="darkgreen@60",),
             aspect=:equal, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_1292409211164016221.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide