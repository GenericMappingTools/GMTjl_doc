# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

subplot(grid=(2,1), region=:global, autolabel=true, margins=0.5,
        title="Low Order Geoid", panel_size=(16,0), frame="lrtb", proj=:Hammer, figsize=16)
	gmtset(MAP_GRID_CROSS_SIZE_PRIMARY=0, FONT_ANNOT_PRIMARY=10, PS_CHAR_ENCODING="Standard+")
	coast(frame="afg", land=:lightbrown, water=:lightblue)
	grdcontour("@osu91a1f_16.nc", cont=10, annot=(int=50,labels=(font=7,)), labels=(dist=10,),
                range=(-1000,-1), pen=((contour=1,pen="thinnest,-"), (annot=1, pen="thin,-")),
                ticks=(gap=(0.25,0.05),labels=""))
	grdcontour("@osu91a1f_16.nc", cont=10, annot=(int=50,labels=(font=7,)), labels=(dist=10,),
                range=(-1,100), ticks=(gap=(0.25,0.05),labels=""))

	coast(frame="afg", land=:lightbrown, water=:lightblue, panel=(2,1))
	grdcontour("@osu91a1f_16.nc", cont=10, annot=(int=50,labels=(font=7,)), labels=(dist=10,),
                range=(-1000,-1), pen=((contour=1,pen="thinnest,-"), (annot=1, pen="thin,-")),
                ticks=(gap=(0.25,0.05),))
	grdcontour("@osu91a1f_16.nc", cont=10, annot=(int=50,labels=(font=7,)), labels=(dist=10,),
                range=(-1,1000), ticks=(gap=(0.25,0.05),))
subplot("show")
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_8285577633788810153.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide