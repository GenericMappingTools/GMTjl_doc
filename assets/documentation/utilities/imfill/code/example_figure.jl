# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = gdalread(TESTSDIR * "assets/coins.jpg");
Ibw1 = binarize(I);
Ibw2 = imfill(Ibw1);
grdimage(I, figsize=5)
grdimage!(Ibw1, figsize=5, xshift=5.1)
grdimage!(Ibw2, figsize=5, xshift=5.1, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_772491466421335683.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide