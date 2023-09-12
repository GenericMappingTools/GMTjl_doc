# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

# Interpolate cashed data ship_15.txt
G = gridit("@ship_15.txt", method=:surface, mask=0.3, preproc=true, V=:q);

# Make a base image from gridded data
grdimage(G, shade=true, coast=(land=:gray, shore=0.5))

# Add automatic contours
grdcontour!(G, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_492953250280474255.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide