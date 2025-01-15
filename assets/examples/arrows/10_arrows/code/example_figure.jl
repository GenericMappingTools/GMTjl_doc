# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
quiver(TESTSDIR * "assets/nuvel1_vx.nc", TESTSDIR * "assets/nuvel1_vy.nc", proj=:guess, lw=1, 
       coast=(shore=:gray70, area=5000), vscale=(inverse=true, scale="400k"), C=:turbo, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_999538644060835513.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide