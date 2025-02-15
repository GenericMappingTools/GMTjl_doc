# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

# Low resolution country polygons
Dit = coast(M=true, DCW=(country=:IT, file=:ODS));

# Extrude and paint the quadrangulated mesh
FV = flatfv("@earth_day_01m", shape=Dit, thickness=0.5);

viz(FV, zsize=0.5, frame=:none, view=(200, 45))
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_13111892240887176106.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide