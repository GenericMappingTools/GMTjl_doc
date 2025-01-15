# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = gdalread(GMT.TESTSDIR * "assets/coins.jpg");
Ibw = binarize(I, band=1)

# Show the two side-by-side
grdimage(I, figsize=6)
grdimage!(Ibw, figsize=6, xshift=6.1, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_10205415336607869394.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide