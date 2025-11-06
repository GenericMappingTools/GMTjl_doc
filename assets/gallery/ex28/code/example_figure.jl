# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
resetGMT() # hide

G = gmtread("@Kilauea.utm.nc");
C = makecpt(cmap="copper", range=(0,1500));
imshow(G, cmap=C, shade=true, frame=(axes="WS", annot=true),
       coast=(shore=true, ocean=:lightblue, frame=(axes="EN", annot=true, grid=true)), show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9634288948668555607.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide