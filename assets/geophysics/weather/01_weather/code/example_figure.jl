# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

# Download the ecmwf forcasts for the _u_ and _v_ components of the wind at 10 meters above the surface
ecmwf(:forecast, var="10u", limits="IHO23", filename="u10.grd")
ecmwf(:forecast, var="10v", limits="IHO23", filename="v10.grd")

windbarbs("u10.grd", "v10.grd", Q="0.25c+s20+w0.15c", I="x10", proj=:guess)
rm("u10.grd") # Hide
rm("v10.grd") # Hide
coast!(shore=true, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_4333984015246297950.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide