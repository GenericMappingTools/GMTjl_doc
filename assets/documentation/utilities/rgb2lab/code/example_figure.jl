# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

# Read an RGB image and compute the Lab transform.
I = gmtread(GMT.TESTSDIR * "assets/seis_section_rgb.jpg");
Ilab = rgb2lab(I);

# The L, a* and b* components
L,a,b = rgb2lab(I, L=true, a=true, b=true);

# Show the five.
grdimage(I, figsize=8)
grdimage!(Ilab, figsize=8, yshift=-3.8)
grdimage!(L, figsize=8, yshift=-3.8)
grdimage!(a, figsize=8, yshift=-3.8)
grdimage!(b, figsize=8, yshift=-3.8, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_9649075906927911487.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide