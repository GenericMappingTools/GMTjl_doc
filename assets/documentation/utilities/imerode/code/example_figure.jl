# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = gmtread(TESTSDIR * "assets/chip.png");
J1 = imerode(I, sel=strel("disk", 10));
J2 = imerode(I, sel=strel("disk", 5));
J3 = imerode(I, sel=strel("disk", 20));
grdimage(I, figsize=6)
grdimage!(J1, figsize=6, xshift=6.1)
grdimage!(J2, figsize=6, xshift=-6.1, yshift=-6.1)
grdimage!(J3, figsize=6, xshift=-6.1, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_2577355414726929947.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide