# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
G = gmtread("@earth_relief_03s", region=[420000, 470000, 4510000, 4535000],
            proj="+proj=utm +zone=33", convert=true);
imshow(G, shade=true, frame=(axes="WS", annot=true),
	coast=(shore=true, ocean=:lightblue, frame=(axes="EN", annot=true, grid=true)))
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_7268345512395416034.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide