# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

subplot(grid=(2,1), autolabel=(Anchor=:TL, offset=0.8), margins=1, panel_size=(15,9))
	histogram!("@v3206_06.txt", limits=(-6000,0,0,30), pen=1, yaxis=(label=:Frequency, suffix=" %"),
	           axis=(axes=:WSne, title=:Histograms, xlabel="Topography (m)", fill=:lightblue), fill=:orange, kind=(freq=true,), bin=250)
		   
	rose(panel=:next, "@fractures_06.txt", limits=(0,1,0,360), swap_xy=true, sector=(width=10, rose=true),
	     norm=true, fill=:orange, axis=(grid=:auto, fill=:lightblue,), pen=1)
subplot("show")
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_4855531435452892868.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide