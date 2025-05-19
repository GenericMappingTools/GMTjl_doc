# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

ecmwf(:forecast, var=["10u", "10v"], R="IHO23", prefix="vel")
windbarbs("vel_10u.grd", "vel_10v.grd", barbs=(length=0.25, width=0.15),
          inc="x10", coast=true, proj=:guess, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_14235336383413745651.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide