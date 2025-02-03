# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

G = grdgravmag3d("@earth_relief_10m", region=(-12.5,-10,35.5,37.5),
                 density=2700, inc=0.05, pad=0.5, z_level=:bottom, f=:g);
viz(G, title="Gorringe FAA", colorbar=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_13877673659793982712.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide