# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
quiver(TESTSDIR * "assets/nuvel1_vx.nc", TESTSDIR * "assets/nuvel1_vy.nc", proj=:guess, lw=1, 
       coast=(shore=:gray70, area=5000), vscale=(inverse=true, scale="400k"), C=:turbo, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_999538644060835513.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide