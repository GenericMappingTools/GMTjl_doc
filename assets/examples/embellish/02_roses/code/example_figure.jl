# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

# Bare-bones plain rose showing arrow towards north and a cross indicating the cardinal directions 
basemap(region=(-5,5,-5,5), proj=:merc, figscale=0.4, frame=:none,
        rose=(map=true, anchor=(0,0), justify=:CM, width=2.5))

# Fancy rose width a north label
basemap!(rose=(map=true, anchor=(0,0), justify=:CM, width=2.5, fancy=true, labels=",,,N"), xshift=3)

# Fancy directional rose at level 3 with labels
basemap!(rose=(map=true, anchor=(0,0), justify=:CM, width=2.5, fancy=3, labels=true),
         region=(-7,7,-5,5), xshift=3.5, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_12110050085784558971.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide