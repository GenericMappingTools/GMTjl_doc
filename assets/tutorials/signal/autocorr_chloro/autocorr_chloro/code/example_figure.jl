# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT	# Hide
D1 = gmtread(TESTSDIR * "assets/cmems_mod_blk_bgc-plankton.csv");	# Hide
lags = 0:3*365;	# Hide

ac = GMT.autocor(D1[:,2], lags)
viz(ac, figsize=(15,6), grid=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_17801099789548906623.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide