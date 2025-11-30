# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT   # Hide
D = gmtread("/vsizip//vsicurl/https://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_state_500k.zip");  # Hide

Df = filter(D, _region=(-125,-66,24,50), _unique=true);  # Keep only the largest polygon per state

pop = gmtread(TESTSDIR * "assets/uspop.csv");
zvals = polygonlevels(Df, pop, att="NAME") / 1e6;
C = makecpt(zvals, auto=:r, reverse =true, cmap=:bamako);

bubblechart(Df, labels="attrib=STUSPS", proj=:guess, zcolor=zvals,
            cmap=C, colorbar=true, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9720144734230891732.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide