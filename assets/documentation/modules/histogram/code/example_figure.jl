# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
histogram("@v3206_06.txt", bin=250, center=true, pen="0.5p", show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9882309136842291859.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide