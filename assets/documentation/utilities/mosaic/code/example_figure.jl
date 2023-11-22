# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

# Get the geographical limits of the Big Island in Hawaii
D = geocoder("Hawaii, Island");

# Get the image tiles of the Big Island in Hawaii using the Bing provider and automatic zoom level
I = mosaic(D, bbox=true);

viz(I)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_10771828636817921970.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide