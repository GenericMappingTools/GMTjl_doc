# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

wiggle("@tracks_09.txt", limits=(185,250,-68,-42), proj=:Mercator, figscale=0.27,
       frame=(axes=:WSne, annot=10, ticks=5, fill=[240 255 240]), G="+red -G-blue",
       D="jBR+w500+l@~m@~rad+o0.5", ampscale=800, pen=:thinnest, par=(:FORMAT_GEO_MAP,:dddF))
plot!("@ridge_09.txt", pen=:thicker)
plot!("@fz_09.txt", pen="thinner,-")
	
# Take label from segment header and plot near coordinates of last record of each track
t = gmtconvert("@tracks_09.txt", E=:l)
for k = 1:length(t)   t[k].text = [t[k].header] end
text!(t, font=(8,"Helvetica-Bold"), angle=50, justify=:RM, header=true,
      offset=(-0.1,-0.1), show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_2089484964567509611.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide