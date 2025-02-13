# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = gmtread(TESTSDIR * "assets/face_bw.png");  #Hide

# Brute cleaning
Ic1 = bwareaopen(I, thresh=1000);

# Retain the "blacks"
Ic2 = bwareaopen(I, thresh=1000, keepblacks=true);

# But this still leaves some noise over the eyes, so clean it again
Ic3 = bwareaopen(Ic2)

grdimage(Ic1, figsize=5)
grdimage!(Ic2, figsize=5, xshift=5)
grdimage!(Ic3, figsize=5, xshift=5, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_10233260016414425700.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide