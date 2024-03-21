# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
GMT.resetGMT() # hide

ship_d = gmtread("@ship_15.txt")
region = gmtinfo(ship_d, inc=1)

R = region.text[1][3:end]
Gship  = nearneighbor(ship_d, region=R, inc="10m", S="40k")
grdcontour(Gship, frame=(axes=:WSne, annot=2), cont=250, annot=1000,
           labels=(dist=5,), proj=:merc, figsize=7.5)

ship_10m = blockmedian(ship_d, region=R, inc="10m")
Gship = surface(ship_10m, region=R, inc="10m")
mask!(ship_d, region=R, inc="10m", fill=:lightgray, tiles=true, xshift=9.1)
grdcontour!(Gship, cont=250, annot=1000, labels=(dist=5,), range=(-8000,0), frame=:same)

mask!(ship_10m, region=R, inc="10m", xshift=-9.1, yshift=9.5, frame=:same)
grdcontour!(Gship, cont=250, annot=1000, labels=(dist=5,), range=(-8000,0))
mask!(end_clip_path=true)   

Gship_clipped = grdclip(Gship, above="-1/NaN")
grdcontour!(Gship_clipped, cont=250, annot=1000, labels=(dist=5,), range=(-8000,0), xshift=9.1)
coast!(land=:gray, shore=:thinnest, frame=:same)
info = grdinfo(Gship, C="n", minmax_pos=true)
plot!(info, marker=:star, ms=0.4, i="10,11", lw=:thick)
text!(text_record([-0.3 3.6], "Gridding with missing data"), region=(0,3,0,4),
      font=(24,"Helvetica-Bold"), justify=:CB, no_clip=true, figscale=2.5,
      proj=:linear, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_4840810856566608029.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide