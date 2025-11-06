# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
coast(region=:global, projection=:ortho, figsize=10, land="brown")
arrows!([1 1 6.5 6.5; -1 10 5 10; 10 19 10 15; 21 10 15 10; 19 1 13.5 6.5],
        lw=2, fill=:darkgreen, ms="20p", endpoint=true, paper=true, noclip=true)
text!(text="Cupidos Invasion", x=14, y=15, justify=:BL, font=18, paper=true, show=1)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_4516638696959167105.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide