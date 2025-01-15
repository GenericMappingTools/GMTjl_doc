# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

# Read an RGB image
I = gmtread(GMT.TESTSDIR * "assets/seis_section_rgb.jpg");
Iycbcr = rgb2YCbCr(I);

# The Cb and Cr components
_,Cb,Cr = rgb2YCbCr(I, Cb=true, Cr=true);

# Show the four.
grdimage(I, figsize=6)
grdimage!(Iycbcr, figsize=6, yshift=-2.84)
grdimage!(Cb, figsize=6, yshift=-2.84)
grdimage!(Cr, figsize=6, yshift=-2.84, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_10579960001188479637.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide