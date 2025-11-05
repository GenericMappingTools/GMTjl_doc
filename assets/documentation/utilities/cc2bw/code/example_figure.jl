# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT	# Hide
I = gmtread(TESTSDIR * "assets/rice.png");	# Hide
BW = binarize(I);	# Hide
CC = bwconncomp(BW);
selection = (CC.area .> 50) .&& ind2bool(filter(CC.bbox, true, _aspect=15/20), CC.num_objects);
BW2 = cc2bw(CC, obj2keep=selection)

# Display the original and filtered images
grdimage(BW, figsize=6, plot=(data=CC.bbox, lc=:red))
grdimage!(BW2, figsize=6, xshift=6.2, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_13604133945599631932.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide