# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

# Low resolution country polygons
Dit = coast(M=true, DCW=(country=:IT, file=:ODS));

# Extrude and paint the quadrangulated mesh
FV = flatfv("@earth_day_01m", shape=Dit, thickness=0.5);

viz(FV, zsize=0.5, frame=:none, view=(200, 45))
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_13111892240887176106.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide