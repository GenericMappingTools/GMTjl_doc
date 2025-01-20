# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = gmtread(TESTSDIR * "assets/rice.png");
J = imsobel(I);
BW = binarize(J);
BW = bwskell(BW);	# Skeletize to get a better approximation of the shapes.
BW = imfill(BW);	# Fill to avoid "double" vectorization (outside and inside grain outline)
D = polygonize(BW);
grdimage(I, figsize=5)
grdimage!(J, figsize=5, xshift=5.05)
grdimage!(BW, figsize=5, xshift=-5.05, yshift=-5.05)
grdimage!(I, figsize=5, xshift=5.05, plot=(data=D, lc=:red), show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_12976122701868640329.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide