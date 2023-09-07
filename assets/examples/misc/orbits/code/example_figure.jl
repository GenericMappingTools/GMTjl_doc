# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	import Pkg; Pkg.add("RemoteS")   # Hide
using GMT, RemoteS

# Compute some Aqua orbits for ... 
orb = sat_tracks(tle=["1 27424U 02022A   23229.43455053  .00001116  00000-0  25175-3 0  9994";
                      "2 27424  98.2892 173.6510 0001539  53.4328  93.9112 14.58243961132289"],
                 start="2023-09-03T08:00:00", duration=300, geocentric=true);

orbits(orb, lon0=45, land=:tomato, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_8244485496579702395.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide