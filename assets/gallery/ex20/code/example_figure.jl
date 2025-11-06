# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

coast(region=:global360, xaxis=(annot=60,), yaxis=(annot=30,), title="Hotspot Islands and Hot Cities",
      land=:darkgreen, water=:lightblue, area=5000, proj=:Win, figsize=15)
plot!("@hotspots.txt", symbol="kvolcano", markerline=:thinnest, fill=:red)

# Overlay a few bullseyes at NY, Cairo, and Perth
cities = [-74 40.45 1.0; 31.15 30.03 1.0; 115.49 -31.58 1.0; -56.16 -34.9 1.0]
plot!(cities, symbol="k@bullseye", show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_793499969305750321.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide