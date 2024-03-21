# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
gmtbegin()
	basemap(region=(0,40,20,60), proj=:merc, frame=(annot=:afg, fill=:lightgreen))
	inset(inset_box=(anchor=:TR, width=6.4, offset=0.5), box=(fill=:pink, pen=0.5), margins=0.6)
		basemap(region=:global360, proj=(name=:laea, center=[20,20]), figsize=5, frame=:afg)
		text(text="INSET", font=18, region_justify=:TR, offset=(away=true, shift=-0.4), noclip=true)
	inset(:end)
	text(text="MAP", font=18, region_justify=:BL, offset=(away=true, shift=0.5))
gmtend(:show)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_10334344294638361924.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide