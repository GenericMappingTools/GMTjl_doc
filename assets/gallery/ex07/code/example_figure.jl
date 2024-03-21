# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
GMT.resetGMT() # hide

coast(region=(-50,0,-10,20), water=:lightblue, land="P300/26:FtanBdarkbrown",
      res=:low, shore=:thinnest, frame=(annot=10,), proj=:Mercator, figsize=18,
      par=(:FORMAT_GEO_MAP, :dddF))
plot!("@fz_07.txt", pen="thinner,-")
scatter!("@quakes_07.txt", h=1, i="0,1,2s0.01", marker=:circle, fill=:red,
         markerline=:thinnest, MarkerSize="3p")
plot!("@isochron_07.txt", pen="thin,blue")
plot!("@ridge_07.txt", pen=(:thicker,:orange))
legend!(mat2ds("S 0.25 c 0.2 red thinnest 0.5 ISC Earthquakes"),
        pos=(inside=true, anchor=:TR, width=5.0, offset=0.5),
        box=(pen=:thick,inner=:thinner,fill=:white),
        par=(:FONT_ANNOT_PRIMARY, "16p,Times-Italic"))
text!(mat2ds([-43 -5; -43 -8; -7 11], ["SOUTH", "AMERICA", "AFRICA"]),
      font=(20,"Helvetica-Bold","white=thin"), show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_5702373168678534147.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide