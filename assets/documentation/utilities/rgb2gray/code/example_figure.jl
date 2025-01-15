# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = gmtread(GMT.TESTSDIR * "assets/bunny_cenora.jpg");
Igray = rgb2gray(I)

# Show the two side-by-side
grdimage(I, figsize=6)
grdimage!(Igray, figsize=6, xshift=6.1, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_7924818034333602085.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide