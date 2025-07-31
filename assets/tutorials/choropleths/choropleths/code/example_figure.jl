# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT   # Hide
D = gmtread("/vsizip//vsicurl/https://www2.census.gov/geo/tiger/GENZ2024/shp/cb_2024_us_state_500k.zip");  # Hide

# Read a simple text file that has population and State name, one per row.
pop = gmtread(TESTSDIR * "assets/uspop.csv");

# Use the polygonlevels function to get the values in the same order as the polygons in D.
zvals = polygonlevels(D, pop, att="NAME") / 1e6;

# Create a color table for the values in zvals.
C = makecpt(zvals, auto=:r, reverse =true, cmap=:bamako);

viz(D, region=(-125,-66,24,50), level=zvals, cmap=C, proj=:guess,
    plot=(data=D,lw=0), title="Population (Millions)", colorbar=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_10477366832373137496.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide