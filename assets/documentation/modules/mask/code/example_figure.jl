# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
t = [repeat([0],19) -90:10:90]      # Some fake data
mask(t, fill=:yellow, inc="30m", region=(-75,75,-90,90), proj=:eqc, search_radius="5d", tiles=true,
     title="Mask for points with r = 5 degrees", xaxis=(annot=:auto, ticks=:auto, grid=180),
     yaxis=(annot=:auto, ticks=:auto, grid=10), show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_5780328525763588960.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide