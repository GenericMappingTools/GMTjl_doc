# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
quiver(getpath4docs("nuvel1_vx.nc"), getpath4docs("nuvel1_vy.nc"), proj=:guess, lw=1, 
       coast=(shore=:gray70, area=5000), vscale=(inverse=true, scale="400k"), C=:turbo, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_4321355766090733558.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide