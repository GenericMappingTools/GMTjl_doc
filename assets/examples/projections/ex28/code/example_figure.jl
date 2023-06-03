# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
G = gmtread("@Kilauea.utm.nc");
C = makecpt(cmap="copper", range=(0,1500));
imshow(G, cmap=C, shade=true, frame=(axes="WS", annot=true),
	coast=(shore=true, ocean=:lightblue, frame=(axes="EN", annot=true, grid=true)))
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_14785666652512770350.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide