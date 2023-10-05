# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

pscoast(region=(-6,20,35,52), DCW=(country="FR,IT", fill=(inv_pattern=8, dpi=300)),
        land=:lightgray, proj=:Mercator, figsize=11, xshift=5)

# Extract a subset of ETOPO2m for this part of Europe
makecpt(cmap=:globe, range=(-5000,5000,50), continuous=true)
grdimage!("@FR+IT.nc", shade=(azim=15, norm="e0.75"),
          frame=(axes=:WsnE, annot=:auto, title="Franco-Italian Union, 2042-45"), yshift=11)
coast!(DCW=(country="FR,IT", fill="red@60"),  show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_9834635761093518065.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide