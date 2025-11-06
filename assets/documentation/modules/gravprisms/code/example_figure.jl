# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

Dcross = gmt("math -T-30/30/0.1 T 0 MUL =");
Dfaa = gravprisms("@prisms.txt", track=Dcross, units=:horizontal, component=:faa, level=7000);
viz(Dfaa, i="0,3")
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_12436126105768106955.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide