# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

ecmwf(:forecast, var=["10u", "10v"], R="IHO23", prefix="vel")
windbarbs("vel_10u.grd", "vel_10v.grd", barbs=(length=0.25, width=0.15),
          inc="x10", coast=true, proj=:guess, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_14235336383413745651.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide