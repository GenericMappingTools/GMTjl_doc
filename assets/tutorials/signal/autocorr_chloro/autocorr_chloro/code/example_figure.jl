# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT	# Hide
D1 = gmtread(TESTSDIR * "assets/cmems_mod_blk_bgc-plankton.csv");	# Hide
lags = 0:3*365;	# Hide

ac = GMT.autocor(D1[:,2], lags)
viz(ac, figsize=(15,6), grid=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_13253303546462165813.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide