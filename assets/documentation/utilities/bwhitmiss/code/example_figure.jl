# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

interval = [2 2 2; 2 1 1; 2 1 0];
I = gmtread(TESTSDIR * "assets/small_squares.png");
J = bwhitmiss(I, interval);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6.05, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_9527565112586141661.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide